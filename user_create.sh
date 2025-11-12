#!/bin/bash
# Скрипт по созданию пользователей по выбору: из файла, просто вводить

#проверка на рут
if ["$(id -u)" !=0]
then
  echo root premissions reqired >&2
  exit 1
fi

#Переменные
shell=/sbin/nologin
file=/var/users
oldIFS=$IFS

#Функция создания юзверя
create_user() {

IFS=$oldIFS

  groupadd $group

    #судоеры
    if ["$group"=it] || ["$group"=security]
    then
        if ! grep "%$group" /etc/sudoers
        then
            cp /etc/sudoers{,.bkp}
            echo '%'$group'ALL=(ALL) ALL' >> /etc/sudoers
        fi
        shell=/bin/bash
    elif ["$user"=admin]
    then
      if ! grep "$user" /etc/sudoers
        then
        cp /etc/sudoers{,.bkp}
        echo $user 'ALL=(ALL) ALL' >> /etc/sudoers
      fi
      shell=/bin/bash
    fi

mkdir /home/$group
useradd $user -g $group -b /home/$group -s $shell
}

if [ ! -z $2 ]
then
    user=$1
    group=$2
    echo Username: $user  Group: $group
    create_user
elif [ -f $file ]
then
IFS=$'\n'
for line in $(cat $file)
do
   user=$(echo $line | cut -d' ' -f1)
   group=$(echo $line | cut -d' ' -f2)
   echo Username: $user Group: $group
   create_user
done

else
    echo Welcome!
    select option in "Add user" "Show users" "Exit"
    do case $option in
            "Add user") read -p "Print username:" user
                        read -p "Print groupname:" group
                        create_user;;
            "Show users") cut -d: -f /etc/passwd;;
            "Exit") break;;
            *) echo Wrong option;;
        esac
    done
fi
