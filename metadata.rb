name             'charon'
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures Charon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"

recipe            "charon::default", "Installs a Charon FUSE client"


depends 'java'

%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

attribute "charon/version",
:description => "Charon version number",
:type => 'string'

attribute "charon/user",
:description => "Username to run Charon as",
:type => 'string',
:default => "glassfish"

