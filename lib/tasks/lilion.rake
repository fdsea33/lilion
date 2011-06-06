namespace :lilion do
  
  desc "Set up lilion first user admin/password"
  task :setup => :environment do
    Person.create!(:name=>"admin", :password=>"password", :password_confirmation=>"password")
  end

end
