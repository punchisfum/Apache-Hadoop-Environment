#!/bin/bash
echo "";

echo "################################################";
echo "##  Welcom To Bayu Dwiyan Satria Uninstaller  ##";
echo "################################################";

echo "";

echo "Use of code or any part of it is strictly prohibited.";
echo "File protected by copyright law and provided under license.";
echo "To Use any part of this code you need to get a writen approval from the code owner: bayudwiyansatria@gmail.com.";

echo "";

if [ $(id -u) -eq 0 ]; then
    
    read -p "Hadoop Administrator Username" username;
    usedel $username;
    rm -rf /home/$username;
    hadoop_version=$(hadoop version 2>&1 | grep Hadoop  | awk '{print $NF}');
    hadoop_home=$(echo "$HADOOP_HOME");
    echo "Unistalling Hadoop $hadoop_version";
    rm -rf $hadoop_home;
    rm -rf /tmp/hadoop*;
    sed '/HADOOP_/d' /etc/profile.d/bayudwiyansatria.sh;

    echo "";
    echo "############################################";
    echo "## Thank You For Using Bayu Dwiyan Satria ##";
    echo "############################################";
    echo "";
    
    echo "Uninstalling Hadoop $hadoop_version Successfully";
    echo "Installed Directory $hadoop_home has removed";
    echo "";

    echo "User $username has been cleared";
    echo "";

    echo "Author    : Bayu Dwiyan Satria";
    echo "Email     : bayudwiyansatria@gmail.com";
    echo "Feel free to contact us";
    
    echo "Planning to use our hadoop installation visit on https://github.com/bayudwiyansatria/Apache-Hadoop-Environment";

    echo "Good Byeeeeee !";
    
    read -p "Please reboot your machine to complete installation? (y/N) [ENTER] [n] : "  reboot;
    if [ -n "$reboot" ] ; then
        if [ "$reboot" == "y" ]; then
            reboot;
        else
            echo "We highly recomended to reboot your system";
        fi
    else
        echo "We highly recomended to reboot your system";
    fi

else
    echo "Only root can uninstall to the system";
    exit 1;
fi