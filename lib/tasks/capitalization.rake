namespace :capitalization do
  desc "Capitalización de strings"

    task :run => :environment do
      puts '------ COMENZANDO LA CAPITALIZACIÓN ------'

      Brand.all.each do |b|
        b.name = b.name
        b.save
      end
      puts '-- Listo las Marcas'

      VehicleModel.all.each do |v|
        v.name = v.name
        v.save
      end
      puts '-- Listo los Modelos'

      Version.all.each do |v|
        v.name = v.name
        v.save
      end
      puts '-- Listo las Versiones'

      Customer.all.each do |c|
        c.first_name = c.first_name
        c.last_name  = c.last_name
        c.save
      end
      puts '-- Listo los Clientes'

      Buyer.all.each do |b|
        b.first_name = b.first_name
        b.last_name  = b.last_name
        b.save
      end
      puts '-- Listo los Interesados'

      puts '------ FIN CAPITALIZACIÓN ------'

  end
end
