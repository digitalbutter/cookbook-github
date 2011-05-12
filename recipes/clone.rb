#
# Author:: Ed Bosher (<ed@butter.com.hk>)
# Copyright:: Copyright (c) 2011 Digital Butter Ltd.
# Cookbook Name:: github
# Recipe:: default
#
# Copyright 2011, Digital Butter Limited
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

node[:github][:repositories].each do |repository|
  github_secure_scm node[:github][:clone_directory] do
    repository repository.src_url
    revision "HEAD"
    remote 'origin'
    action :sync # or :rollback
    provider Chef::Provider::GithubSecureGit
    user "root"
    group "root"
    ssh_key Base64.decode64(data_bag_item(node[:github][:key_bag], node[:github][:key_item])['value'])
  end
end