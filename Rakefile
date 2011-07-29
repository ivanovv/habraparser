task :build do
  begin
    sh 'rm ./pkg/*.gem'
  rescue Exception => e
    puts 'Previous gems in pkg/ not found.'
  end 
  
  sh 'gem build habraparser.gemspec'
  sh 'mv ./*.gem ./pkg/'
end

task :install => [:build] do
  sh 'gem install --local ./pkg/*.gem'
end

task :uninstall do
  sh 'gem uninstall habraparser'
end

task :reinstall => [:uninstall, :build, :install] do
  puts 'Gem has been reinstalled.'
end

task :tests do
  sh 'rspec spec/ --format doc'
end