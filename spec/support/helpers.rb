RSpec.configure do |config|
  config.include Features::CapybaraExt, type: :feature
  config.include Warden::Test::Helpers
  config.include Features::SignInHelpers, :type => :feature
end
