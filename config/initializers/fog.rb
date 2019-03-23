require "fog/aws"

CarrierWave.configure do |config|
  # Specifies carrier wave to use fog-aws as opposed to the typical fog package
  # MUST be first line here to prevent errors when setting other configurations
  config.fog_provider = "fog/aws"

  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
    :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
  }

  config.fog_public = false
  config.fog_directory = ENV["AWS_BUCKET"]
end
