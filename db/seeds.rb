# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
 Organization.create(name: "GrepRuby", city: "Indore", phone: 07312363363, address: "Tower 61, 1st floor,Bhanwarkuaa", state: "Madhya Pradesh", country: "India", pin_code: 452001, domain: "salary-slip-generator.herokuapp.com")
 employee = Employee.create(first_name: "HR-", last_name: "GrepRuby", address: "191-sector A", city: "Indore", pin_code: 452009, dob: '10-10-1990', degignation: "HR", gender: "male", date_of_joining: '12-12-2015', organization_id: 1, password: "123456789", password_confirmation:"123456789", email: "hr2@yopmail.com",confirmed_at: "2015-12-23 11:42:15")
 employee.create_role(name: "admin")



