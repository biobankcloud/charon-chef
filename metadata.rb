name             'charon'
maintainer       "Tiago Oliveira"
maintainer_email "toliveira@lasige.di.fc.ul.pt"
license          "Apache v2.0"
description      'Installs/Configures Charon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"

recipe            "charon::default", "Installs a Charon FUSE client"


depends 'java'
depends 'kagent'
depends 'hadoop'

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute "charon/user",
:display_name => "Username to run Charon as",
:description => "Username to run Charon as",
:type => 'string',
:required => "required"

attribute "charon/group",
:display_name => "Group to run Charon as",
:description => "Group to run Charon as",
:type => 'string',
:required => "required"

attribute "charon/user_email",
:display_name => "Email of user used to share data",
:description => "Email of user used to share data",
:type => 'string',
:required => "required"


#attribute "charon/password",
#:display_name => "User password",
#:description => "User password",
#:type => 'string',
#:required => "required"

attribute "charon/mount_point",
:description => "The name of the mount point of Charon",
:type => 'string',
:required => "required"

attribute "charon/email",
:description => "Email address for Charon administrator",
:type => 'string',
:required => "required"

attribute "charon/use_only_aws",
:description => "Do you want to Run Charon only with AWS credentials?",
:type => 'string',
:required => "required"

attribute "aws/access_key",
:description => "Aws access key",
:type => 'string',
:required => "required"

attribute "aws/secret_key",
:description => "Aws secret key",
:type => 'string',
:required => "required"

attribute "aws/cannonical_id",
:description => "Aws cannonical id",
:type => 'string',
:required => "required"

attribute "google/access_key",
:description => "Google access key",
:type => 'string',
:required => "required"

attribute "google/secret_key",
:description => "Google secret key",
:type => 'string',
:required => "required"

attribute "google/email",
:description => "Google email",
:type => 'string',
:required => "required"

attribute "rackspace/access_key",
:description => "RackSpace access key",
:type => 'string',
:required => "required"

attribute "rackspace/secret_key",
:description => "RackSpace secret key",
:type => 'string',
:required => "required"

attribute "azure/access_key",
:description => "Azure access key",
:type => 'string',
:required => "required"

attribute "azure/secret_key",
:description => "Azure secret key",
:type => 'string',
:required => "required"

attribute "hdfs/charon_rep_dir",
:description => "Azure secret key",
:type => 'string'

attribute "hdfs/conf_dir",
:description => "The location of HDFS configuration directory",
:type => 'string'
