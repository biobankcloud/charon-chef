# charonfs-chef
Cookbook for installing CharonFS

-> First you should install Chef:

1- wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb
2- sudo dpkg -i chefdk_0.7.0-1_amd64.deb

-> To test if chef was well installed run:

3- chef-solo --version
4- berks --version

-> After that, you sould create the clouds accounts to:

5- 

3- git clone https://github.com/biobankcloud/charon-chef.git

4- cd charon-chef

5- berks vendor /tmp/cookbooks

6- fill up the charon.json file (credentials info bellow - just copy the keys)

7- sudo chef-solo -c solo.rb -j charon.json

8- Charon will be mounted at '/srv/charon_fs'. Just use it as the local file system.
