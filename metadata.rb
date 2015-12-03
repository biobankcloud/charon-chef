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
:display_name => "Unix user to run Charon as",
:description => "Unix user to run Charon as",
:type => 'string',
:required => "required"

attribute "charon/group",
:display_name => "Unix group to run Charon as",
:description => "Unix group to run Charon as",
:type => 'string',
:required => "required"

attribute "charon/user_email",
:display_name => "User email",
:description => "User email",
:type => 'string',
:required => "required"

attribute "charon/site_id_name",
:display_name => "User name",
:description => "User name",
:type => 'string',
:required => "required"

attribute "charon/locations/default_location",
:display_name => "The default location where Charon will store data and metadata: (use 'coc' or 'cloud')",
:description => "The default location where Charon will store data and metadata: (use 'coc' or 'cloud')",
:type => 'string',
:default => "cloud",
:required => "required"

attribute "charon/locations/use_coc",
:display_name => "If you want to use a cloud-of-clouds configuration set this to 'true'",
:description => "If you want to use a cloud-of-clouds configuration set this to 'true'",
:type => 'string',
:default => "false",
:required => "required"

attribute "charon/locations/use_cloud",
:display_name => "If you want to use a single cloud (aws) configuration set this to 'true'",
:description => "If you want to use a single cloud (aws) configuration set this to 'true'",
:type => 'string',
:default => "true",
:required => "required"

attribute "charon/credentials/aws/access_key",
:display_name => "Aws access key",
:description => "Aws access key",
:type => 'string'

attribute "charon/credentials/aws/secret_key",
:display_name => "Aws secret key",
:description => "Aws secret key",
:type => 'string'

attribute "charon/credentials/google/access_key",
:display_name => "Google access key",
:description => "Google access key",
:type => 'string'

attribute "charon/credentials/google/secret_key",
:display_name => "Google secret key",
:description => "Google secret key",
:type => 'string'

attribute "charon/credentials/rackspace/access_key",
:display_name => "RackSpace access key",
:description => "RackSpace access key",
:type => 'string'

attribute "charon/credentials/rackspace/secret_key",
:display_name => "RackSpace secret key",
:description => "RackSpace secret key",
:type => 'string'

attribute "charon/credentials/azure/access_key",
:display_name => "Azure access key",
:description => "Azure access key",
:type => 'string'

attribute "charon/credentials/azure/secret_key",
:display_name => "Azure secret key",
:description => "Azure secret key",
:type => 'string'

attribute "charon/cannonical_id/aws_can_id",
:display_name => "Aws cannonical id to share between different accounts",
:description => "Aws cannonical id to share between different accounts",
:type => 'string'

attribute "charon/cannonical_id/google_email",
:display_name => "Google email to share between different accounts",
:description => "Google email to share between different accounts",
:type => 'string'

attribute "charon/hdfs/repo_dir",
:description => "Azure secret key",
:type => 'string'

attribute "charon/hdfs/conf_dir",
:description => "The location of HDFS configuration directory",
:type => 'string'
