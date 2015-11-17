Category.destroy_all
Category.reset_pk_sequence
EventTemplate.destroy_all
EventTemplate.reset_pk_sequence

template_list = [
  ["blue", "http://goo.gl/nI8p6z"],
  ["teal", "http://goo.gl/N71KKn"],
  ["red", "http://goo.gl/tO9nGb"],
  ["orange", "http://goo.gl/Z9K86J"],
  ["lime", "http://goo.gl/ZfSy65"],
  ["light-blue", "http://goo.gl/jOZnwA"],
  ["grey", "http://goo.gl/Iyv9Ov"],
  ["pink", "http://goo.gl/VP5a83"],
  ["green", "http://goo.gl/UEfXVc"],
  ["cyan", "http://goo.gl/8Eh0sA"],
  ["brown", "http://goo.gl/OXnBqS"],
  ["purple", "http://goo.gl/erHIiU"]
]

category_list = [
  ["Music", "Intimate, house concerts, major music festival,
    and the occasional dance party", ""],
  ["Food & drink", "Dinner parties, tasting and big-time festivals", ""],
  ["Classes", "Enlightening seminars, technical workshops,
    and fitness classes", ""],
  ["Arts", "Plays, comedy nights, art exhibitions and film festivals", ""],
  ["Parties", "Casual happy hours, singles nights,
    and all-night celebrations", ""],
  ["Sport & Wellness", "Obstacle races, drop-in yoga classes,
    and the big game", ""],
  ["Networking", "Business mixers, hobby meetups, and panel discussions", ""]
]

category_list.each do |name, description, banner|
  Category.find_or_create_by(name: name, description: description,
                             banner: banner)
end

template_list.each do |name, url|
  EventTemplate.find_or_create_by(name: name, image: url)
end
