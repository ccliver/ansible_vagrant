#!/bin/bash


# Install Ansible
apt-get -y update
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible
cp /srv/synced_data/ansible.cfg /etc/ansible/

# Setup the local and Ansible hosts files
HOST=1
echo "[hosts]" > /etc/ansible/hosts
while [[ $HOST -le $1 ]]
do
  echo "172.16.1.$HOST host$HOST" >> /etc/hosts
  echo "host$HOST  ansible_connection=ssh ansible_user=ansible" >> /etc/ansible/hosts
  HOST=`expr $HOST + 1`
done

# Create the Ansible user
useradd -m -d /home/ansible ansible
mkdir /home/ansible/.ssh
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA6Mbuji8F8U4wTxLdggzQZ3vx/0wdMMamkWKWSH+FfQJqMbCW
8zhmqWK6u2ahugXMjDS9Vy/s8uLZNgmOx6DpVIaxbqZlI7aC9yp3YKK6GGkg1sop
EqBcZrTSSpkNZv1d0bmD+IpxHua7ywHH4BBzR6CRPiNdjUnzge5IPu0BvyGCyj1l
6GWUMo6alrZm3UOYqmdeKrT/kZQ514DZxRG/JJHW/p/KSDBA49xb123hUJHDrAwc
KVZluFNOZvOMOAK6KbJ1+4e7/uFcGzeibXR6RssdogcIeWPbeYJHXOA9QCmGJpVa
UnEJDf2N+eNkQcs3TszwQYVZZwH1Ys+fZA72ewIDAQABAoIBAESMCEXgfQyBLOKs
OISKh3hh3HKElHf/l59qe7zfqIyWgHUffmQjMMAircBvyaJBAOoswbECEPG5caNj
DyOkM/HLNEbUQyZQIaLtY3gWk1yK4Lu/jnbIuE0aZG7JQVQZul3/FmjDQ+qIobZ3
UMefsILgOsUknvDzXPzfEXFOU9xXTxyMr3ug3gOsB7amHPr9m/eFrEld2v/NsUx/
2KdkUdQnGf3/wjqmyiLDSQ5LLdR7ntMiYNY33JVCWBy8W3qGMqSy6PxI+Jq7jqys
OmpwHE5qG5zU2ksZjY83IrfJ0x5c46BMpCa4rLTheBbJac+4wJbIAY5YMvykI4vl
MrhERrkCgYEA+sJ/UKCY8Gb23UzoX5sgUkP8ZiPzAaU0SxhB2smFqzqEOq9xsw9S
ZnLyckCIrm895yQ5BnD3Ow82ReWwze4NGr/CqpCcSQC0trUIrvYzgyJjofIlhh94
gxVxJgS+3fl3maEMd+H9uQTN6s1XXG0dxWEiVF2+TOy6iFlc46iQT50CgYEA7aQ7
Tb7BMmmoOPzzNwLABv3vSgQ1guiqJghjExoz6oV6tndnEufUtAuGM8yP51B38CBJ
/fs3vvKdifufnx4tG5MyUouDIpx9QG/J25fnsh4mpM8j4qD35f9FTVhV3N23WXNl
4rntXvOaCS2PzZvy/S01+qm/JtZSnnmRGhRo3vcCgYANNkQ4/k0wlWw6Wrv/lY/N
ZdGdnBVIp+iqcDvACFAnpmyjHu1RruP7i+DkTiwlbK0JSapLgZY1IWcNpb18DCfa
mfHqxLXHTuc2nTE47rXmGeC//p8lgvD5jx6oDyXzUhqQGKEsi9avceZbkbghoYop
BSYm5c2KBgsJ9hNj11TLLQKBgQDC4gkkQ8gKQK2NNpt6RI4X7c175KHBnm5SzFP7
iWSD8jzlQFxOG8LKeBzxg9OLfekuCjzDxW488JgTXT/U7JlPYNJG8VR0YOMyobpn
lFaVMra8N4cVRq6ldkduG4AmpcjD2af3XER2ts1es3eXxUlrKNV4oBY7kk2k2ssN
GSm7lwKBgQD1zywI8lhmXxzWSXAmkGPIq0RkG2yych0tEKfEpNf1t95bPin0cjYL
RJHJzpRGQgcnvrnEM4uMBS6jEuTyiPozn8pt/il4xy3U7joAVGW+OXzn491HSyCi
stZTbPBXW6NtLdYeZaz6UXqczM6kKxhjqAiYGCmPoj/UFuDJ3z0ojQ==
-----END RSA PRIVATE KEY-----" > /home/ansible/.ssh/id_rsa
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/id_rsa
chown -R ansible:ansible /home/ansible/.ssh
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible
