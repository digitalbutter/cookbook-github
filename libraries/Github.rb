begin
  require 'git-ssh-wrapper'
rescue LoadError
  Chef::Log.warn("Missing gem 'git-ssh-wrapper'")
end

begin
  require 'rest_client'
rescue LoadError
  Chef::Log.warn("Missing gem 'rest_client'")
end

begin
  require 'json'
rescue
  Chef::Log.warn("Missing gem 'json'")
end

module Opscode
  module Github
    module Github
      def show_repo_info(name,repo)
          response = RestClient.get "https://github.com/api/v2/json/repos/show/#{name}/#{repo}"

          #If it is found, parse and return the response
          if response.code = 200
            return JSON.parse response.to_str
          end

          #If it doesn't exist return nothing
          if response.code = 400
            return nil
          end

          #For everything else report the exception
          raise "Github returned #{response.code}. Response: #{response.to_str}"
      end
    end
  end
end