class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(uid: auth[:uid]).first_or_create do |user|
      user.uid                = auth.uid
      user.screen_name        = auth.extra.raw_info.screen_name
      user.name               = auth.extra.raw_info.name
      user.oauth_token_secret = auth.credentials.secret
      user.oauth_token         = auth.credentials.token
    end
  end
end
