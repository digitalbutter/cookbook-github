begin
  require 'octopi'
rescue LoadError
  Chef::Log.warn("Missing gem 'octopi'")
end

begin
  require 'git-ssh-wrapper'
rescue LoadError
  Chef::Log.warn("Missing gem 'git-ssh-wrapper'")
end

module Opscode
  module Github
    module Github
      include Octopi
    end
  end
end