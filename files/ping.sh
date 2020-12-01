#!/bin/bash
#  Run this file from inside the ansible server container ./start.sh
ansible all -m ping -i /project/inventory.yml

#docker exec  ttans0 sh -c "ansible all -m ping -i /project/inventory.yml " 
