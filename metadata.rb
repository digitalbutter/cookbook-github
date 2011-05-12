maintainer       "Digital Butter Limited"
maintainer_email "devops@butter.com.hk"
license          "Apache 2.0"
description      "Installs/Configures github"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
depends          "git"
version          "0.0.1"
recipe           "github", "Installs dependencies for this module."
recipe           "force-clone", "Clones all the requested github repositories."


attribute "github/repositories",
  :display_name => "Github Repositories",
  :description => "Github repositories to manage based on definitions",
  :default => []