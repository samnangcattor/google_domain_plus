require_relative 'boot'

require 'rails/all'
require "googleauth"
require "googleauth/stores/file_token_store"
require 'google/apis/plus_domains_v1'
require "google/apis/drive_v2"
require "google/apis/drive_v3"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoogleDomainPlus
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
