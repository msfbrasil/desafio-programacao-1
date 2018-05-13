Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
    {
      :secure_image_url => 'true',
      :image_size => 'normal',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    scope: 'public_profile', info_fields: 'id,name,link'
end

