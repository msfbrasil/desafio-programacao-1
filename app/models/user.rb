class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true
  validates :provider, uniqueness: { scope: :uid }
  
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      begin
        user.location = auth_hash['info']['location']
        user.url = auth_hash['info']['urls'][user.provider.capitalize]
      rescue
        Rails.logger.info user.provider + " don't have location or url fields."
      end
      user.save!
      user
    end
  end
end
