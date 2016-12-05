class User < ActiveRecord::Base
  # Remember to create a migration!
  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid).first_or_initialize do |user|
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end

    user
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new('EAACEdEose0cBAAUBfhjaZAYnZBOi0oocXcLLzZBsN1MsM0S3Mkc8SVy46uvLCey9HuHBGbXfU9dtN5mnjFYf7oFjhGnUik9PnaqxOZBT8H1MmJpQKWNZB2Idzzzu0MHBChzL3FjsinKpL1BwZAtwzufFU6MWOsilCp5ZAWl7v5ZAsAZDZD') #oauth_code
    # En la siguiente pagina biene sobre el uso de Koala y la API de fb 
    # https://github.com/arsduo/koala/wiki/Graph-API
    # El token se obtiene de la siguiente pagina
    # http://developers.facebook.com/tools/explorer/
  end

end
