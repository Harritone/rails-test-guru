require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# Dotenv::Railtie.load

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Vladivostok'
    config.i18n.default_locale = :ru
    config.autoload_paths << config.root.join('lib', 'clients')
    # config.autoload_paths << config.root.join('services')
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
