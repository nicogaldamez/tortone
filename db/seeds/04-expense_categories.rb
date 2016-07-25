puts 'BEGIN Seed ExpenseCategories'
puts '----------------'

ExpenseCategory.where(name: 'FACEBOOK').first_or_create do |cat|
  cat.name        = 'FACEBOOK'
  cat.description = 'Publicidad en Facebook'
end

ExpenseCategory.where(name: 'DIARIO EL DIA').first_or_create do |cat|
  cat.name        = 'DIARIO EL DIA'
  cat.description = 'Publicidad en el diario EL DIA'
end

ExpenseCategory.where(name: 'MERCADO LIBRE').first_or_create do |cat|
  cat.name        = 'MERCADO LIBRE'
  cat.description = 'Publicaciones en Mercado Libre'
end

ExpenseCategory.where(name: 'LAVADO DE AUTO').first_or_create do |cat|
  cat.name        = 'LAVADO DE AUTO'
  cat.description = 'Gasto en lavadero de autos'
end

puts "ExpenseCategories count: #{ExpenseCategory.count}"

puts '----------------'
puts 'END Seed ExpenseCategories'
