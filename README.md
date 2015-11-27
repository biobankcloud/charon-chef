# Cookbook for installing CharonFS

This cookbook automates the installation of CharonFS, a cloud-of-clouds-backed file system that improves the dependability and the availability of data stored in public clouds. 

**1 - First, install chef and git:**

```
$ wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb
$ sudo dpkg -i chefdk_0.7.0-1_amd64.deb
$ sudo apt-get install git
$ git config --global url."https://".insteadOf git://
```

**2 - To test if they were correctly installed, run:**
```
$ chef-solo --version
$ berks --version
$ git --version
```
**3 - After that, create the accounts in the clouds and get the API credentials:**

To create the accounts, follow the links bellow. If you prefer, you can use four different Amazon S3 regions instead of four different cloud providers. In this case, read the step 4 (bellow) to configure CharonFS in that way.
* [Amazon S3](https://aws.amazon.com/s3/) - follow the yellow tab in the upper right corner.
* [Google Storage](https://cloud.google.com/storage/docs/signup) - first, create a google account. After that, follow the steps in the link to activate the Google Cloud Storage.
* [RackSpace Files](http://www.rackspace.co.uk/) - follow the green tab in the upper right corner to sign up in the RackSpace Cloud. Sign up for the 'Managed Infrastructure' option (you will be billed only for the storage you use).
* [Windows Azure Storage](https://azure.microsoft.com/en-us/) - first, create a microsoft account. After that follow the free trial in the link.

After creating the accounts, you shall find your API credentials. Follow the steps bellow:

* To find the Amazon S3 keys, go to the AWS Management Console and click in S3 service. In the upper right corner, click in your account name and enter in the Security Credentials. After that, in the Access Keys separator you may generate your access and secret keys.

* To find the Google Storage keys, go to the Google API Console, pick the project you have created before. In the upper left corner, open the galery list and go to the Storage separator. Choose the Configuration tab on the left side, and go to the Interoperable Access. There you shall find your keys.

* To find the RackSpace keys, go to the Control Panel. In the upper right corner, you may find how to get your secret key. The access key is just your login username.

* To find the Windows Azure keys, go to the Windows Azure portal. Create a new storage project. Select this new project, and at the bottom of the page, you can find the key management. In this case, your access key is your storage project name and you secret key is the primary key in the key management.

**4 - To install and run the CharonFS:**

```
$ git clone https://github.com/biobankcloud/charon-chef.git
$ cd charon-chef
$ berks vendor /tmp/cookbooks
```
* Fill up the charon.json file:
  * the `user` and `group` attributes should be filled with the result of the command `$ echo $USER`.
  * the `user_email` attribute should be the user email.
  * the `use_only_aws` attribute should be set to `true` if you only want to use Amazon S3 to replicate the data. In this case, you only need to fill the credentials for the `aws` provider. 
  * the `access_key` and `secret_key` attributes for the four clouds must be fill up with the credentials fetched in the step 3.
  * the `cannonical_id` attribute under the `aws` provider can be found in the Security Credentials page of your AWS Management Console.
  * the `email` attribute under the `google` provider should be the google email associated to your google cloud storage account.
  * the `conf_dir` attribute of `hdfs` sould indicate the path to the folder containing the hdfs configurations files (ex: core-site.xml).
```
$ sudo chef-solo -c solo.rb -j charon.json
```
* Charon will be mounted at `/srv/Charon/charon_fs`. Just use it as any local file system.

**5 - To Stop and re-run CharonFS:**

* To umount the Charon file system run:
```
$ cd /srv/Charon
$ ./Charon_umount.sh /srv/Charon/charon_fs
```
* To re-run Charon:
```
$ cd /srv/Charon
$ nohup ./Charon_mount.sh > /srv/Charon/logs &
```
