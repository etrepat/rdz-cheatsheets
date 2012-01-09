require 'bundler/setup'
Bundler.require

require 'rocco'
require 'rocco/tasks'

desc "Build Rocco cheatsheets into /public"
Rocco.make 'public/', ['lib/**/*.rb'], {
  :language      => 'ruby',
  :comment_chars => '#',
  :template_file => nil,
  :stylesheet    => 'http://jashkenas.github.com/docco/resources/docco.css'
}

task :default => :rocco
