Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  		:scope => 'read_stream', :display => 'popup'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end