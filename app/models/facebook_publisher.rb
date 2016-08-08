class FacebookPublisher
  
  require 'koala'
    
  TOKEN = ENV['FACEBOOK_TOKEN']

  # A partir de un vehículo y un mensaje, crea un álbum en Facebook
  # y carga las imágenes del vehículo
  # Ej: FacebookPublisher.new(vehicle).post('un_mensaje_sobre_auto')
  def initialize(vehicle)
    @graph   = Koala::Facebook::API.new(TOKEN)
    @vehicle = vehicle
  end
  
  def post
    album_id = build_album()
    results = upload_images(album_id)
    
    {status: :ok}
    
    rescue Exception => e
      return {status: :error} # Si ocurre error retorna error
  end
  
  
  private
  
  def upload_images(album_id)
    @graph.batch do |api|
      images.map do |image_url|
        api.put_connections(album_id, 'photos', url: image_url)
      end
    end
  end
  
  def build_album()
    album = @graph.put_connections("me", "albums",
      location: 'Tortone Automotores',
      name: @vehicle.identification,
      message: _message()
    )
    
    return album['id']
  end
  
  def images      
    @vehicle.attachments.map do |attachment|
      attachment.file.remote_url
    end
  end
  
  def _message
    "#{@vehicle.identification} | #{@vehicle.year} | #{@vehicle.kilometers}"
  end
  
end