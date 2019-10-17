require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    #----------ここから下を追加---------------------------
    #RSpecを利用したコントローラの機能テストは、Rails5からはrequest specで
    #記述することが推奨されるみたいなので、controller_specsも省きました。
    config.generators do |g|
      g.test_framework :rspec,
                       helper_specs: false,
                       routing_specs: false,
                       view_specs: false,
                       controller_specs: false
    end
    #----------ここまで-----------------------------------


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
