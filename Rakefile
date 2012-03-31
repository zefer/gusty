desc "Loads the service environment, config, etc"
task :environment do
  require "./app.rb"
end

desc "Start a console"
task :console do
  sh "bundle exec irb -r ./app.rb"
end
