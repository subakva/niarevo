# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

if RAILS_ENV == 'development'
  User.create!(
    :username => 'subakva',
    :password => 'password',
    :password_confirmation => 'password',
    :email => 'jdwadsworth@gmail.com'
  ) unless User.exists?(:username => 'subakva')
end
