CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = 'corndogapp'

  config.aws_credentials = {
    access_key_id: 'AKIAJVBDATADRCEFIDLQ',
    secret_access_key: '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',
    region: 'us-east-1'
  }
end
