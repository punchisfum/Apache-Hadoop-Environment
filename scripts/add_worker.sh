#!/bin/bash

# User Access
if [ $(id -u) -eq 0 ]; then
    # Network Configuration

    interface=$(ip route | awk '/^default/ { print $5 }');
    ipaddr=$(ip -o -4 addr list "$interface" | awk '{print $4}' | cut -d/ -f1);
    gateway=$(ip route | awk '/^default/ { print $3 }');
    subnet=$(ip addr show "$interface" | grep "inet" | awk -F'[: ]+' '{ print $3 }' | head -1);
    network=$(ipcalc -n "$subnet" | cut -f2 -d= );
    prefix=$(ipcalc -p "$subnet" | cut -f2 -d= );
    hostname=$(echo "$HOSTNAME");
    
    # User Generator
    read -p "Do you want to create user for hadoop administrator? (y/N) [ENTER] (y) " createuser;
    createuser=$(printf '%s\n' "$createuser" | LC_ALL=C tr '[:upper:]' '[:lower:]' | sed 's/"//g');

    if [ -n createuser ] ; then
        if [ "$createuser" == "y" ] ; then
            read -p "Enter username : " username;
            read -s -p "Enter password : " password;
            egrep "^$username" /etc/passwd >/dev/null;
            if [ $? -eq 0 ]; then
                echo "$username exists!"
            else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p $pass $username
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
            fi
            usermod -aG $username $password;
        else
            read -p "Do you want to use exisiting user for hadoop administrator? (y/N) [ENTER] (y) " existinguser;
            if [ "$existinguser" == "y" ] ; then
                read -p "Enter username : " username;
                egrep "^$username" /etc/passwd >/dev/null;
                if [ $? -eq 0 ]; then
                    echo "$username | OK" ;
                else
                    echo "Username isn't exist we use root instead";
                    username=$(whoami);
                fi 
            else 
                username=$(whoami);
            fi
        fi
    else
        read -p "Enter username : " username;
        read -s -p "Enter password : " password;
        egrep "^$username" /etc/passwd >/dev/null;
        if [ $? -eq 0 ]; then
            echo "$username exists!"
        else
            pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
            useradd -m -p $pass $username
            [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
            usermod -aG $username $password;
            echo "User $username created successfully";
            echo "";
        fi
    fi

    echo "";
    echo "############################################";
    echo "##        Adding Worker Nodes             ##";
    echo "############################################";
    echo "";

    read -p "Do you want to setup worker? (y/N) [ENTER] (n) " workeraccept;
    workeraccept=$(printf '%s\n' "$workeraccept" | LC_ALL=C tr '[:upper:]' '[:lower:]' | sed 's/"//g');

    if [ -n "$workeraccept" ] ; then 
        if [ "$workeraccept" == "y" ] ; then 
            while [ "$workeraccept" == "y" ] ; do 
                read -p "Please enter worker IP Address [ENTER] " worker;
                echo -e  ''$worker' # Worker' >> $HADOOP_HOME/etc/worker;
                if [[ -f "~/.ssh/id_rsa" && -f "~/.ssh/id_rsa.pub" ]]; then 
                    echo "SSH already setup";
                    echo "";
                else
                    echo "SSH setup";
                    echo "";
                    ssh-keygen;
                    echo "Generate SSH Success";
                fi

                if [ -e "~/.ssh/authorized_keys" ] ; then 
                    echo "Authorization already setup";
                    echo "";
                else
                    echo "Configuration authentication";
                    echo "";
                    touch ~/.ssh/authorized_keys;
                    echo "Authentication Compelete";
                    echo "";
                fi
                ssh-copy-id -i ~/.ssh/id_rsa.pub "$username@$ipaddr"
                ssh-copy-id -i ~/.ssh/id_rsa.pub "$worker"
            
                ssh $worker "wget https://raw.githubusercontent.com/bayudwiyansatria/Apache-Hadoop-Environment/master/express-install.sh";
                ssh $worker "chmod 777 express-install.sh";
                ssh $worker "./express-install.sh" $version "http://bdev.bayudwiyansatria.com/dist/hadoop" "$username" "$password" "$ipaddr";
                scp /home/$username/.ssh/authorized_keys /home/$username/.ssh/id_rsa /home/$username/.ssh/id_rsa.pub $username@$worker:/home/$username/.ssh/
                ssh $worker "chown -R $username:$username /home/$username/.ssh/";
                ssh $worker "echo -e  ''$ipaddr' # Master' >> $HADOOP_HOME/etc/hadoop/workers";
                read -p "Do you want to add more worker? (y/N) [ENTER] (n) " workeraccept;
                workeraccept=$(printf '%s\n' "$workeraccept" | LC_ALL=C tr '[:upper:]' '[:lower:]' | sed 's/"//g'); 
            done
        fi
    fi

    echo "Worker added";
else
    echo "Only root may can install to the system";
    exit 1;
fi