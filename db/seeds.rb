# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.destroy_all
EventTemplate.destroy_all

template_list = [
    ['blue', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402582/blue_k0b4yt.png'],
    ['teal', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/teal_yajwze.png'],
    ['red', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/red_ug5h6q.png'],
    ['orange', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/orange_btitzu.png'],
    ['lime', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/lime_xlfi2l.png' ],
    ['light-blue', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/light-blue_o5ildf.png'],
    ['grey',  'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402582/grey_bfdrfw.png'],
    ['pink',  'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/pink_uzoho9.png'],
    ['green', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402582/green_r7ixce.png'],
    ['cyan', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402582/cyan_r5ptzy.png'],
    ['brown', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402582/brown_jzwgq6.png'],
    ['purple', 'http://res.cloudinary.com/neddinn/image/upload/c_scale,h_92,w_101/v1442402583/purple_rryrhz.png']
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
