puts 'BEGIN Seed Vehicle Brands'
puts '----------------'

BRANDS = ['Ford', 'Peugeot', 'Volkswagen', 'Chevrolet', 'Kia', 'Citroen', 'Audi', 'BMW', 'Chery', 'Alfa Romeo']

BRANDS.each do |brand_name| 
  Brand.where(name: brand_name).first_or_create do |brand|
    brand.name = brand_name.upcase
  end
end
puts "Brand count: #{Brand.count}"

puts '----------------'
puts 'END Seed Vehicle Brands'
