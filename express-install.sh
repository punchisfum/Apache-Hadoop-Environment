#!/bin/bash
echo "";

echo "################################################";
echo "##  Welcom To Bayu Dwiyan Satria Installation ##";
echo "################################################";

echo "";

echo "Use of code or any part of it is strictly prohibited.";
echo "File protected by copyright law and provided under license.";
echo "To Use any part of this code you need to get a writen approval from the code owner: bayudwiyansatria@gmail.com.";

echo "";

# User Access
if [ $(id -u) -eq 0 ]; then

    echo "################################################";
    echo "##        Checking System Compability         ##";
    echo "################################################";

    echo "";
    echo "Please wait! Checking System Compability";
    echo "";

    HADOOP_HOME="/usr/local/hadoop";
    if [ -e "$HADOOP_HOME" ]; then
        echo "";
        echo "Hadoop is already installed on your server.";
        echo "If you want to update it, run this command: sh /scripts/update_hadoop";
        echo "";
        exit 1;
    fi

    argv="$1";
    echo $argv;
    if [ "$argv" ] ; then
        distribution="hadoop-$argv";
        packages=$distribution;
    else
        distribution="stable";
        version="3.2.0";
        packages="hadoop-$version";
    fi

    # Packages Available
    mirror=http://bdev.bayudwiyansatria.com/hadoop;
    url=$mirror/$distribution/$packages.tar.gz;
    echo "Checking availablility hadoop $version";
    if curl --output /dev/null --silent --head --fail "$url"; then
        echo "Hadoop version is available: $url";
    else
        echo "Hadoop version isn't available: $url";
        exit 1;
    fi

    echo "Hadoop version $version install is in progress, Please keep your computer power on";

    wget $mirror/$distribution/$packages.tar.gz -O /tmp/$packages.tar.gz;

    # System Operation Information
    if type lsb_release >/dev/null 2>&1 ; then
    os=$(lsb_release -i -s);
    elif [ -e /etc/os-release ] ; then
    os=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release);
    elif [ -e /etc/*-os-release ] ; then
    os=$(awk -F= '$1 == "ID" {print $3}' /etc/*-os-release);
    fi

    os=$(printf '%s\n' "$os" | LC_ALL=C tr '[:upper:]' '[:lower:]');

    if [ $os == "ubuntu" ] ; then
        apt-get -y update && apt-get -y upgrade;
    else 
        yum -y update && yum -y upgrade;
    fi

    if [ $os == "ubuntu" ] ; then
        apt-get -y install git && apt-get -y install wget;
    else 
        yum -y install git && yum -y install wget;
    fi

    echo "Installing Hadoop Version  $distribution";
    echo "";

    # Extraction Packages
    tar -xvf /tmp/$packages.tar.gz;
    mv $packages $HADOOP_HOME;

    # User Generator
    username="hadoop";
    password="hadoop";
    egrep "^$username" /etc/passwd >/dev/null;
    if [ $? -eq 0 ]; then
        echo "$username exists!"
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass $username
        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    fi

    usermod -aG $username $password;
    chown $username:root -R $HADOOP_HOME;
    chmod g+rwx -R $HADOOP_HOME;

    echo "################################";
    echo "## Hadoop Configuration Setup ##";
    echo "################################";
    echo "";

        # Configuration Variable
    configuration=(core-site.xml hdfs-site.xml httpfs-site.xml kms-site.xml mapred-site.xml yarn-site.xml);
    for xml in "${configuration[@]}" ; do 
        wget https://raw.githubusercontent.com/bayudwiyansatria/Apache-Hadoop-Environment/master/$packages/etc/hadoop/$xml -O /tmp/$xml;
    done

    java=$(echo "$JAVA_HOME");
    if [ -z "$java" ] ; then
        if [ $os == "ubuntu" ] ; then
            apt-get -y install git && apt-get -y install wget;
        else 
            yum install java-1.8.0-openjdk;
            java=$(dirname $(readlink -f $(which java))|sed 's^/bin^^');
            echo -e "export JAVA_HOME="$java"" >> /home/$username/.bash_profile;
            echo -e "# Apache Hadoop Environment" >> /home/$username/.bash_profile;
            echo -e "export HADOOP_HOME=$HADOOP_HOME" >> /home/$username/.bash_profile;
            echo -e "export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop" >> /home/$username/.bash_profile;
            echo -e "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> /home/$username/.bash_profile;
            echo -e "export HADOOP_INSTALL=${HADOOP_HOME}" >> /home/$username/.bash_profile;
            echo -e "export HADOOP=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin" >> /home/$username/.bash_profile;
            env=$(echo "$PATH");
            newenv="$env:"${HADOOP_HOME}"/bin:"${HADOOP_HOME}"/sbin";
            echo -e "export $newenv";
        fi
    else
        java=$(dirname $(readlink -f $(which java))|sed 's^/bin^^');
        echo -e "export JAVA_HOME="$java"" >> /home/$username/.bash_profile;
        echo -e "# Apache Hadoop Environment" >> /home/$username/.bash_profile;
        echo -e "export HADOOP_HOME=$HADOOP_HOME" >> /home/$username/.bash_profile;
        echo -e "export HADOOP_CONF_DIR="${HADOOP_HOME}"/etc/hadoop" >> /home/$username/.bash_profile;
        echo -e "export HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_HOME}"/lib/native" >> /home/$username/.bash_profile;
        echo -e "export HADOOP_INSTALL="${HADOOP_HOME}"" >> /home/$username/.bash_profile;
        echo -e "export HADOOP="${HADOOP_HOME}"/bin:"${HADOOP_HOME}"/sbin" >> /home/$username/.bash_profile;
        env=$(echo "$PATH");
        newenv="$env:"${HADOOP_HOME}"/bin:"${HADOOP_HOME}"/sbin";
        echo -e "export $newenv";
    fi

    echo "############################################";
    echo "## Thank You For Using Bayu Dwiyan Satria ##";
    echo "############################################";

    echo "Installed Directory /usr/local/hadoop";
    echo "Installing Hadoop $version Successfully";
    echo "User $username";
    echo "Pass $password";

else
    echo "Only root may add a user to the system";
    exit 1;
fi