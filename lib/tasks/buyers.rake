namespace :buyers do
  desc "Compradores"

    task :delete_old => :environment do
      puts '------ COMENZANDO ELIMINACION DE COMPRADORES ------'

      Buyer.where('created_at < ?', Date.today-20.days).destroy_all

      puts '------ FIN ELIMINACIÓN DE COMPRADORES ------'

  end
end
