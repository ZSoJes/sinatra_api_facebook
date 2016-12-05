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
    @facebook ||= Koala::Facebook::API.new('EAACEdEose0cBAGftfb7MbMxdni6Inije6dywg3pghfWM3cIGqHO3kmU8lZCDy4ZC8GF8MGurs2CTVFaCt4ZBPR8BQxx5uxZBZBbKo5qmTkVJToPwUlGVXoskR9vFzGCcLrwGZB6c1NaPDKBf5stATsx8uRNouadGSjJkCy7yjUogZDZD') #oauth_code
    # @facebook.get_object("me?fields=name,picture")
  end

end
