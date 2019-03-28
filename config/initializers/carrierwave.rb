require "fog/aws"

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    # this is where rspec will look to clean up the uploaded files after the tests have run
    config.store_dir = "#{Rails.root}/spec/support/uploads"
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    # Specifies carrier wave to use fog-aws as opposed to the typical fog package
    # MUST be first line here to prevent errors when setting other configurations
    config.fog_provider = "fog/aws"
    config.cache_dir = "#{Rails.root}/tmp/uploads" # Prevents errors with Heroku's read only file system

    config.fog_credentials = {
      :provider => "AWS",
      :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
      :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
    }

    config.storage = :fog

    config.fog_public = false
    config.fog_directory = ENV["AWS_BUCKET"]
  end
end
