# Create links
50.times do |i|
  link = Link.new(title: Faker::Lorem.sentence,
                  href: Faker::Internet.url,
                  comment: Faker::Lorem.paragraph)
  link.save
end
