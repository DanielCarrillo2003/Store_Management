require_relative "boot"

require "rails/all"

require "active_model/railtie"

require "active_job/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EcommerceAndStorage
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.to_prepare do
      ActionText::ContentHelper.allowed_attributes << 'data-controller'
      ActionText::ContentHelper.allowed_tags << 'div'
      ActionText::ContentHelper.allowed_tags.delete('figure')
      ActionText::ContentHelper.allowed_tags.delete('figcaption')
    end

    config.after_initialize do
      config.action_view.logger = nil
    end

    config.i18n.default_locale = :es
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "America/Mexico_City"
    
    # config.eager_load_paths << Rails.root.join("extras")
    

    #DESCOMENTA ESTO PARA ACTIVAR SIDEKIQ JOBS
    #------------------------------------------------------------------------------------
    #------------------------------------------------------------------------------------

    config.active_job.queue_adapter = :sidekiq

    #------------------------------------------------------------------------------------
    #------------------------------------------------------------------------------------


    config.action_mailer.default_url_options = { host: 'example.com' }

    config.action_mailer.delivery_method = :smtp 
    config.action_mailer.smtp_settings = {
      address: 'localhost',
      port: 1025
    }
  end
end
