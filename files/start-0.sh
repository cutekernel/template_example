#!/bin/bash
#  Run this file from inside the ansible server container ./start.sh
ansible nodes -m ping -i fips_testing/nodes_inventory.yml -k -K
