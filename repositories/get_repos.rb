require 'json'
require 'git'

def clone_git_repository(from, to)
  message = 'Cloning from ' + from + ' to ' + to +'\n'
  print message
  Git.clone(from, to , :bare => false)
end

path = '.'
if defined? ARGV[0]
  path = ARGV[0]
end
json = IO.read('repos.json')
repositories = JSON.load(json)
repositories['repositories'].each { |package|  clone_git_repository(package['clone_from'], './'+package['clone_to']) }


