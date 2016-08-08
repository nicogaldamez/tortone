require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "b46db87e72697cd6645a5f8ea5633ad7ca092b949e6adf25b2710c5ee76d6efd"

  url_format "/media/:job/:name"

  if !(Rails.env.development? || Rails.env.test?)
    datastore :file,
              root_path: Rails.root.join('public/system/dragonfly', Rails.env),
              server_root: Rails.root.join('public')
  else
    datastore :s3,
              bucket_name: ENV['BUCKET_NAME'],
              access_key_id: ENV['S3_KEY'],
              secret_access_key: ENV['S3_SECRET'],
              url_scheme: 'https'
  end

end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
