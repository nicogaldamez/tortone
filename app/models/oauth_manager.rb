class OauthManager

  require 'koala'

  API_KEY    = ENV['FACEBOOK_API_KEY']
  APP_SECRET = ENV['FACEBOOK_APP_SECRET']
  PAGE_ID    = '129247780746057'
  
  attr_reader :oauth
  
  def initialize(vehicle)
    uri = Rails.root.join('vehicles', "#{vehicle.id}", 'publish')
    @oauth = Koala::Facebook::OAuth.new(API_KEY, APP_SECRET, uri)
  end
  
  def url
    @oauth.url_for_oauth_code(permissions: "publish_actions, manage_pages, publish_pages")
  end
  
  def get_page_access_token(code)
    user_token  = @oauth.get_access_token(code)
    user_graph  = Koala::Facebook::API.new(user_token)
    page_token  = user_graph.get_page_access_token(PAGE_ID) 
    
    page_token
  end


end