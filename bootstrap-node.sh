#!/bin/bash

# Setup the local hosts file
HOST=1
while [[ $HOST -le $1 ]]
do
  echo "172.16.1.`expr $HOST + 10` host$HOST" >> /etc/hosts
  HOST=`expr $HOST + 1`
done

apt-get -y update
apt-get -y install python
useradd -m -d /home/ansible ansible
mkdir /home/ansible/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoxu6OLwXxTjBPEt2CDNBne/H/TB0wxqaRYpZIf4V9AmoxsJbzOGapYrq7ZqG6BcyMNL1XL+zy4tk2CY7HoOlUhrFupmUjtoL3KndgoroYaSDWyikSoFxmtNJKmQ1m/V3RuYP4inEe5rvLAcfgEHNHoJE+I12NSfOB7kg+7QG/IYLKPWXoZZQyjpqWtmbdQ5iqZ14qtP+RlDnXgNnFEb8kkdb+n8pIMEDj3FvXbeFQkcOsDBwpVmW4U05m84w4AropsnX7h7v+4VwbN6JtdHpGyx2iBwh5Y9t5gkdc4D1AKYYmlVpScQkN/Y3542RByzdOzPBBhVlnAfViz59kDvZ7" >> /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible
