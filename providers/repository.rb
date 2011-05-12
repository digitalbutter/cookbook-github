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

action :create do
  begin
    authenticated_with :login => node[:github][:username], :token => node[:github][:token] do
      #Check to see if the repo exists
      repo = Repository.find(:name => @new_resource.name, :user => node[:github][:username])

      #If it doesn't create it
      if(repo == nil && node[:github][:force_create])
        repo = Repository.create(:name => @new_resource.name)
      end

      @new_resource.updated_by_last_action(true)
    end
  rescue APIError => error
    Chef::Log.info "The github provider failed with: #{error}"
  end
end