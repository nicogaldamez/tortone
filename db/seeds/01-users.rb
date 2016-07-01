puts 'BEGIN Seed Users'
puts '----------------'

matias = User.where(email: 'matiastortone@gmail.com').first_or_initialize do |user|
  user.password              = '123123123'
  user.password_confirmation = '123123123'
end
if matias.new_record?
  matias.save!
  puts 'User created => matiastortone@gmail.com, 12313213'
end

puts "User count: #{User.count}"

puts '----------------'
puts 'END Seed Users'
