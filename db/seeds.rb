# Create links
100.times do |i|
  link = Link.new(title: Faker::Lorem.sentence,
                  href: Faker::Internet.url,
                  comment: Faker::Lorem.paragraph)
  link.save
end
