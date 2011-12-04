# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TextContent.create(:identity => "welcome" , :title => 'Velkommen', :body => 'Lorem ipsum dolor sit amet')
User.create(:email => "max@synthmax.dk" , :name => 'Max Grønlund', :password => 'rosalina', :role => 'super')