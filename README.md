## Base local setup for Ansible development

* By default, launch a "manager" to act as an Ansible server.
  * Ansible files stored in `/etc/ansible`. 
  * Ansible commands should be run as the `ansible`.
* Number of hosts to launch can be increased by incrementing `HOSTS` in the Vagrantfile (default is 1).
* Any ports that need to be forwarded can be configured via the `PORTS_TO_FORWARD` Hash in the Vagrantfile.
