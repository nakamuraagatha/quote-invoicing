CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],                        # required
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],                        # required
      region:                 'us-west-2'
  }

  config.fog_directory    = ENV['S3_BUCKET_NAME']
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

end

