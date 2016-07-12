puts 'BEGIN Seed Vehicle Models'
puts '----------------'

PEUGEOT = ['206', '207', '208', '307', '308', '407', '408']
FORD    = ['Fiesta', 'Ranger', 'Focus']

PEUGEOT.each do |model_name| 
  VehicleModel.where(name: model_name).first_or_create do |model|
    model.name  = model_name.upcase
    model.brand = Brand.find_by(name: 'PEUGEOT') 
  end
end

FORD.each do |model_name| 
  VehicleModel.where(name: model_name).first_or_create do |model|
    model.name  = model_name.upcase
    model.brand = Brand.find_by(name: 'FORD') 
  end
end

puts "VehicleModel count: #{VehicleModel.count}"

puts '----------------'
puts 'END Seed Vehicle Models'
