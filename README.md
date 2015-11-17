# Cookbook for installing CharonFS

This cookbook automates the installation of Charon, a cloud-of-clouds backed file system which improves the dependability and the availability the data stored in the clouds. 

<<<<<<< HEAD
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
=======
**1 - First you should install Chef and git:**

* wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb
* sudo dpkg -i chefdk_0.7.0-1_amd64.deb
* sudo apt-get install git
* git config --global url."https://".insteadOf git://

**2 - To test if Chef and git was well installed run:**

* chef-solo --version
* berks --version
* git --version

**3 - After that, you must create the clouds accounts and get the API credentials before installing and running Charon:**

* Go to the [DepSKy](http://cloud-of-clouds.github.io/depsky/ ) web page and follow the steps in the 'Getting Started with DepSky' section to find the credentials.

**4 - Now that all the accounts are created is time to intall and run Charon:**

* git clone https://github.com/biobankcloud/charon-chef.git
* cd charon-chef
* berks vendor /tmp/cookbooks
* Fill up the charon.json file:
  * the 'user' and 'group' should be fill with the result of the command 'echo $USER'
  * the 'user_email' should be the user email
  * the 'access_key' and 'secret_key' attributes for the four clouds must be fill up with the credentials fetched in the step 8-.
  * the 'cannonical_id' attribute under the 'aws' provider can be found in the Security Credentials page of your AWS Management Console.
  * the 'email' attribute under the 'google' provider should be the google email associated to your google cloud storage account.
  * the 'conf_dir' attribute of 'hdfs' sould indicate the path to the folder containing the hdfs configurations files (ex: core-site.xml) 
* sudo chef-solo -c solo.rb -j charon.json
* Charon will be mounted at '/srv/charon_fs'. Just use it as the local file system.

**5 - Stop and re-runing Charon:**

* To umount the Charon file system run:
  * cd /srv/Charon
  * ./Charon_umount.sh charon_fs
* To re-run Charon:
  * cd /srv/Charon
  * nohup ./Charon_mount.sh > /srv/Charon/logs &
>>>>>>> ca672148ddc801985537b1c0b54f9e27b125c9ec
