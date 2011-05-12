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

include 'Octopi'

action :create do
  authenticated_with :login => node[:github][:username], :token => node[:github][:token] do
    repo = Repository.create(:name => @new_resource.name)
    issue = repo.open_issue :title => "Sample issue",
                            :body => "This issue was opened using GitHub API and Octopi"
    puts issue.number
  end

  @new_resource.updated_by_last_action(true)
end