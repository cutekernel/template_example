#!/bin/bash
#  Run this file from inside the ansible server container ./start.sh
#ansible nodes -m ping -i fips_testing/nodes_inventory.yml -k -K
ansible-playbook /project/ssh-playbook.yml -i /project/inventory.yml -k -K
