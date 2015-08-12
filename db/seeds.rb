# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

template_list = [
    ['Green', 'http://res.cloudinary.com/neddinn/image/upload/v1438782351/temp13_ovz0ue.png '],
    ['Blue', 'http://res.cloudinary.com/neddinn/image/upload/v1438782351/temp15_hj7rqz.png'],
    ['Purple', 'http://res.cloudinary.com/neddinn/image/upload/v1438782350/temp7_doqim8.png '],
    ['Red','http://res.cloudinary.com/neddinn/image/upload/v1438782351/temp12_mbqjcp.png '],
    ['Black', 'http://res.cloudinary.com/neddinn/image/upload/v1438782350/temp8_y8qt9v.png'],
    ['Gray', 'http://res.cloudinary.com/neddinn/image/upload/v1438782350/temp6_ng6krr.png'],
    ['Sky-blue','http://res.cloudinary.com/neddinn/image/upload/v1438782350/temp2_dy7nkp.png '],
    ['Brown', 'http://res.cloudinary.com/neddinn/image/upload/v1438782351/temp9_lhchbz.png']
]

category_list = [
    ['Music', 'Intimate, house concerts, major music festival, and the occasional dance party', ''],
    ['Food & drink', 'Dinner parties, tasting and big-time festivals', ''],
    ['Classes', 'Enlightening seminars, technical workshops, and fitness classes', ''],
    ['Arts', 'Plays, comedy nights, art exhibitions and film festivals', ''],
    ['Parties', 'Casual happy hours, singles nights, and all-night celebrations', ''],
    ['Sport & Wellness', 'Obstacle races, drop-in yoga classes, and the big game', ''],
    ['Networking', 'Business mixers, hobby meetups, and panel discussions', '']
]

category_list.each do |name, description, banner|
  Category.find_or_create_by(name: name, description: description, banner: banner)
end

template_list.each do |name, url|
  EventTemplate.find_or_create_by(name: name, image: url)
end


