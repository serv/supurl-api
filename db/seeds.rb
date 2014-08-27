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

# Create fake users
# username: faker{{number}}
# password: 123123
base_username = 'faker'
base_password = '123123'
50.times do |i|
  username = base_username + i.to_s
  email = username + '@gzxcv.com'
  User.create(username: username,
              email: email,
              password: base_password,
              password_confirmation: base_password)
end

# Create admin & client
admin_username = 'admin'
admin_email = 'admin@gzxcv.com'
password = '123123'
admin = User.create(username: admin_username,
                    email: admin_email,
                    password: password,
                    password_confirmation: password)

client = Client.create(api_key: 'key',
                       api_secret: 'secret',
                       website_url: 'http://localhost:3000',
                       redirect_uri: 'auth/supurl',
                       name: 'Supurl',
                       user_id: admin.id)
