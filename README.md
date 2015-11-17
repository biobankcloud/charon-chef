# Cookbook for installing CharonFS

This cookbook automates the installation of Charon, a cloud-of-clouds backed file system which improves the dependability and the availability the data stored in the clouds. 

**1 - First you should install Chef and git:**

```$ wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb
$ sudo dpkg -i chefdk_0.7.0-1_amd64.deb
$ sudo apt-get install git
$ git config --global url."https://".insteadOf git://```

**2 - To test if Chef and git was well installed run:**

* chef-solo --version
* berks --version
* git --version

**3 - After that, you must create the clouds accounts and get the API credentials before installing and running Charon:**

For create the accounts follow the links bellow:
* [Amazon S3](https://aws.amazon.com/s3/) - follow the yellow tab in the upper right corner.
* [Google Storage](https://cloud.google.com/storage/docs/signup) - you sould first create an google mail account. After that follow the steps in the link to activate the Google Cloud Storage.
* [RackSpace Files](http://www.rackspace.co.uk/) - follow the green tab in the upper right corner to sign up in the RackSpace Cloud. Sign up for the 'Managed Infrastructure' option (you will only be billed for the storage you use).
* [Windows Azure Storage](https://azure.microsoft.com/en-us/) - You should first create an microsoft mail account. After that follow the free trial in the link.

After creating the accounts you'll have to find your API credentials. Follow the steps bellow:

* To find Amazon S3 keys go to the AWS Management Console, click in S3 service, now, in the upper right corner click in your account name and go to the Security Credentials. After that, in the Access Keys separator you can generate your access and secret keys.

* To find Google Storage keys go to the Google API Console, pick the project you have created before, and then, in the upper left corner, go to the Storage separator. Now choose the Configuration tab on the left side, and then go to the Interoperable Access and there you can find your keys.

* To find RackSpace keys, go to the Control Panel. In the upper right corner you can find how to get your secret key. The access key is just your login username.

* To find Windows Azure keys go to the windows azure portal. First you need to create a new storage project. After select this new project, at the bottom of the page, you can find the key management. In this case your access key is your storage project name and you secret key is the primary key in the key management.

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
