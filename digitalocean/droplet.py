import digitalocean
import os
import sys
import time

f = open("demo.sh", "r")
DATA = f.read() 


TOKEN = os.environ.get('DOTOKEN') 
SSH = os.environ.get('DOSSHKEY')
manager = digitalocean.Manager(token=TOKEN)
my_droplets = manager.get_all_droplets()

droplet = digitalocean.Droplet(token=TOKEN,
                               name='vishal',
                               region='ams3', # Amster
                               image='ubuntu-16-04-x64', # Ubuntu 16.04 x64
                               size_slug='4gb',  # 4GB
                               ssh_keys=[23909941], #Automatic conversion
                               user_data= DATA,
                               backups=False)
droplet.create()
actions = droplet.get_actions()
for action in actions:
    action.load()
    # Once it shows complete, droplet is up and running
    state =  action.status
    print (state)

while True:
    if state == 'completed':
        print ("Droplet is active")
        print (state)
        break
    print ("Waiting for 2 sec. Dropet not ready yet.")
    time.sleep(2)
    actions = droplet.get_actions()
    for action in actions:
        action.load()
        # Once it shows complete, droplet is up and running
        state =  action.status
