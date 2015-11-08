puts "Seeding..."

password = ENV['DEFAULT_PASSWORD'] || "password"
users = [{ name: 'Admin User', admin: true }, { name: 'Test User' }]

users.each do |user|
  email = "#{user[:name].split(' ')[0]}@example.com"
  User.find_or_initialize_by(email: email).tap do |record|
    record.password = record.password_confirmation = password
    record.name = user[:name]
    record.admin = user.fetch(:admin, false)
    record.skip_confirmation!
  end.save
end

puts "Finished."
