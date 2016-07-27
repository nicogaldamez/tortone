puts 'BEGIN Seed Vehicle Brands'
puts '----------------'

BRANDS = ['FORD', 'PEUGEOT', 'VOLKSWAGEN', 'CHEVROLET', 'KIA', 'CITROEN', 'AUDI', 'BMW', 'CHERY', 'ALFA ROMEO']

BRANDS.each do |brand_name| 
  Brand.where(name: brand_name).first_or_create do |brand|
    brand.name = brand_name
  end
end
puts "Brand count: #{Brand.count}"

puts '----------------'
puts 'END Seed Vehicle Brands'
