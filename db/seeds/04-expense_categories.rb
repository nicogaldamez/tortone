puts 'BEGIN Seed ExpenseCategories'
puts '----------------'

ExpenseCategory.where(name: 'FACEBOOK').first_or_create do |cat|
  cat.name        = 'FACEBOOK'
end

ExpenseCategory.where(name: 'DIARIO EL DIA').first_or_create do |cat|
  cat.name        = 'DIARIO EL DIA'
end

ExpenseCategory.where(name: 'MERCADO LIBRE').first_or_create do |cat|
  cat.name        = 'MERCADO LIBRE'
end

ExpenseCategory.where(name: 'LAVADO DE AUTO').first_or_create do |cat|
  cat.name        = 'LAVADO DE AUTO'
end

puts "ExpenseCategories count: #{ExpenseCategory.count}"

puts '----------------'
puts 'END Seed ExpenseCategories'
