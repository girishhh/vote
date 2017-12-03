# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
District.transaction do
arr=District.create([{name: "koppal"},{name: "tumkur"}])
place_arr = [{key1: [{name: "kanakagiri"},{name: "kaluburgi"}],key2: [{name: "congress",candidate_name: "girish"},{name: "bjp",candidate_name: "darshan"}]}, {key1: [{name: "sira"},{name: "kyatasandra"}],key2: [{name: "congress",candidate_name: "gowda"},{name: "bjp",candidate_name: "rahul"}]}]

count=0
arr.each do |dis|
consti_arr = dis.places.create(place_arr[count][:key1])
consti_arr.each do |const|
const.parties.create(place_arr[count][:key2])
end
count=count+1
end
end
count=0
