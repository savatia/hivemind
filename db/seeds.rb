# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:'brian', email:'foobar@foo.com', password:'foobar', admin:'true',activated: true, activated_at: Time.zone.now)
User.create!(name:'foobar', email:'foo@bar.com', password:'foobar', admin:'false',activated: true, activated_at: Time.zone.now)
User.create!(name:'john', email:'john@foo.com', password:'foobar', admin:'false',activated: true, activated_at: Time.zone.now)
User.create!(name:'james', email:'james@foo.com', password:'foobar', admin:'false',activated: true, activated_at: Time.zone.now)
User.create!(name:'mary', email:'mary@foo.com', password:'foobar', admin:'false',activated: true, activated_at: Time.zone.now)

Field.create!(name:"Java")
Field.create!(name:"C-sharp")
Field.create!(name:"C-plusplus")
Field.create!(name:"Python")
Field.create!(name:"Ruby")
Field.create!(name:"Android")

Topic.create!(name:"Programming", general:true, url:"programming")
Topic.create!(name:"Web Design", general:true, url:"web_design")
Topic.create!(name:"Project Management", general:true, url:"project_management")
Topic.create!(name:"Netowrking", general:true, url:"networking")
Topic.create!(name:"Cryptology", general:true, url:"cryptology")
Topic.create!(name:"Security", general:true, url:"security")
Topic.create!(name:"Operating Systems", general:true, url:"operating_systems")
Topic.create!(name:"Music", general:false, url:"music")
Topic.create!(name:"Sports", general:false, url:"sports")
Topic.create!(name:"Humour", general:false, url:"humor")
Topic.create!(name:"Pictures",general:false, url:"pictures")
Topic.create!(name:"Gaming", general:false, url:"gaming")