require 'spec/rake/spectask'


task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.warning = false
  t.rcov = false
  t.spec_opts = ["--colour", "--diff"]
end

namespace :git do
  desc "this pushes to github"
  task :push do
    sh "git push origin master"
  end
end