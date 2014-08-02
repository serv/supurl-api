# Create tags
50.times do |i|
  tag_name = Faker::Lorem.word
  tag = Tag.new(display_name: tag_name,
                shortcut: tag_name)
  tag.save
end

# Create links
50.times do |i|
  link = Link.new(title: Faker::Lorem.sentence,
                  href: Faker::Internet.url,
                  comment: Faker::Lorem.paragraph)
  link.save

  tags = Tag.order("RANDOM()").limit(3)

  tags.each do |t|
    Taggable.create(link_id: link.id, tag_id: t.id)
  end

end
