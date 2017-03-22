Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], 
  scopes: "public_profile, email", 
  info_fields: "first_name, middle_name, last_name, name, name_format, email"
end