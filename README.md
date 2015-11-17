# Cookbook for installing CharonFS

This cookbook automates the installation of Charon, a cloud-of-clouds backed file system which improves the dependability and the availability the data stored in the clouds. 

-> First you should install Chef and git:

1- wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb
2- sudo dpkg -i chefdk_0.7.0-1_amd64.deb
3- sudo apt-get install git 
4- git config --global url."https://".insteadOf git://

-> To test if Chef and git was well installed run:

3- chef-solo --version
4- berks --version
5- git --version

-> After that, you must create the clouds accounts and get the API credentials before installing and running Charon:

5- Go to the web page 'http://cloud-of-clouds.github.io/depsky/' and follow the steps in the 'Getting Started with DepSky' section to find the credentials.

-> Now that all the accounts are created is time to intall and run Charon:

3- git clone https://github.com/biobankcloud/charon-chef.git
4- cd charon-chef
5- berks vendor /tmp/cookbooks

6- Fill up the charon.json file:
  6.1- the 'user' and 'group' should be fill with the result of the command 'echo $USER'
  6.2- the 'user_email' should be the user email
  6.3- the 'access_key' and 'secret_key' attributes for the four clouds must be fill up with the credentials fetched in the step 5-.
  6.4- the 'cannonical_id' attribute under the 'aws' provider can be found in the Security Credentials page of your AWS Management Console.
  6.5- the 'email' attribute under the 'google' provider should be the google email associated to your google cloud storage account.
  6.6- the 'conf_dir' attribute of 'hdfs' sould indicate the path to the folder containing the hdfs configurations files (ex: core-site.xml) 
7- sudo chef-solo -c solo.rb -j charon.json
8- Charon will be mounted at '/srv/charon_fs'. Just use it as the local file system.

-> Stop and re-runing Charon:

9- To umount the Charon file system run:
  9.1- cd /srv/Charon
  9.2- ./Charon_umount.sh charon_fs
10- To re-run Charon:
  10.1- cd /srv/Charon
  10.2- ./Charon_mount.sh
