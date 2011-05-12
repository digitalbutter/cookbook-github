#
# Author:: Ed Bosher (<ed@butter.com.hk>)
# Copyright:: Copyright (c) 2011 Digital Butter Ltd.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Opscode::Github::Github

include Chef::Mixin::ShellOut

action :create do
  begin
    authenticated_with :login => node[:github][:username], :token => data_bag_item(node[:github][:token_bag], node[:github][:token_item])['value'] do
      #Check to see if the repo exists
      begin
        repo = Repository.find(:name => @new_resource.name, :user => node[:github][:account])
        @new_resource.updated_by_last_action(true)
      rescue Octopi::NotFound
        #If it doesn't create it
        if node[:github][:force_create]
          Chef::Log.info "#{@new_resource.name} does not exist. Will now create the github repository."
          repo = Repository.create(:name => @new_resource.name, :user => node[:github][:account])

          #Make the repo private
          Api.api.post("/repos/set/private/#{node[:github][:account]}/#{@new_resource.name}", { :cache => false })

#         TODO Fix this throwing a 401 error
#          @new_resource.collaborators.each do |collaborator|
#            Api.api.post("/teams/#{collaborator}/repositories?name=#{node[:github][:account]}/#{@new_resource.name}", { :cache => false })
#          end

          @new_resource.updated_by_last_action(true)
        end
      end
    end
  rescue APIError => error
    Chef::Log.info "The github provider failed with: #{error}"
  end
end

action :fetch_upstream do
  result = shell_out!('git remote add upstream https://github.com/modxcms/revolution.git', :cwd => node[:github][:clone_directory] + "/" + @new_resource.name, :returns => [0,128]).stdout
  if result != "fatal: remote upstream already exists."
    #fetch it
    shell_out!('git pull upstream master', :cwd => node[:github][:clone_directory] + "/" + @new_resource.name, :returns => [0,128])
    shell_out!('git push origin master', :cwd => node[:github][:clone_directory] + "/" + @new_resource.name, :returns => [0,128])
  end
end
