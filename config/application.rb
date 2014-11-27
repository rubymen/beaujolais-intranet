require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module BeaugolaisIntranet
  class Application < Rails::Application
    config.action_mailer.smtp_settings = {
      :address   => 'smtp.mandrillapp.com',
      :port      => 587,
      :enable_starttls_auto => true,
      :user_name => 'contact@rdlh.io',
      :password  => 'gtB9LmkfRBToz5nDG7zoOg',
      :authentication => 'login',
      :domain => 'beaujolais-intranet.herokuapp.com',
    }

    config.encoding = "utf-8"
    config.i18n.default_locale = :fr
    config.eager_load = true

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :delete, :put, :options]
      end
    end
  end
end
