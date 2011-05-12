#
# Author:: Ed Bosher (<ed@butter.com.hk>)
# Copyright:: Copyright (c) 2011 Digital Butter Ltd.
#
# Modified version of https://github.com/opscode/chef/blob/master/chef/lib/chef/resource/scm.rb
# Author:: Daniel DeLeo (<dan@kallistec.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
#
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

actions :checkout, :export, :sync, :diff, :log

attribute :destination, :kind_of => String, :name_attribute => true
attribute :repository, :kind_of => String
attribute :revision, :kind_of => String
attribute :user, :kind_of => [String, Integer]
attribute :group, :kind_of => [String, Integer]
attribute :svn_username, :kind_of => String
attribute :svn_password, :kind_of => String
attribute :svn_arguments, :kind_of => String
attribute :svn_info_args, :kind_of => String

# Capistrano and git-deploy use ``shallow clone''
attribute :depth, :kind_of => Integer
attribute :enable_submodules, :kind_of => [TrueClass, FalseClass]
attribute :remote, :kind_of => String
attribute :ssh_wrapper, :kind_of => String
attribute :ssh_key, :kind_of => String