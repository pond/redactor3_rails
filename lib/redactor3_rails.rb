require 'redactor3_rails/version'
require 'orm_adapter'

module Redactor3Rails
  IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/tiff', 'image/x-png']

  FILE_TYPES = ['application/msword', 'application/pdf', 'text/plain', 'text/rtf', 'application/vnd.ms-excel']

  autoload :Http, 'redactor3_rails/http'
  autoload :Devise, 'redactor3_rails/devise'

  module Backend
    autoload :CarrierWave, 'redactor3_rails/backend/carrierwave'
  end
  require 'redactor3_rails/orm/base'
  require 'redactor3_rails/orm/active_record'
  require 'redactor3_rails/orm/mongoid'
  require 'redactor3_rails/engine'

  mattr_accessor :images_file_types, :files_file_types
  @@images_file_types = ['jpg', 'jpeg', 'png', 'gif', 'tiff']
  @@files_file_types = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'rtf', 'txt']

  class << self
    def base_controller=(v)
      @base_controller = v
    end

    def base_controller
      @base_controller ||= ApplicationController
    end

    def image_model=(v)
      @image_model = v
    end

    def image_model
      @image_model ||= Redactor3Rails::Image
    end

    def file_model=(v)
      @file_model = v
    end

    def file_model
      @file_model ||= Redactor3Rails::File
    end

    def image_uploader=(v)
      @image_uploader = v
    end

    def image_uploader
      @image_uploader ||= Redactor3RailsImageUploader
    end

    def file_uploader=(v)
      @file_uploader = v
    end

    def file_uploader
      @file_uploader ||= Redactor3RailsFileUploader
    end

    def devise_user=(v)
      @devise_user = v
    end

    def devise_user
      @devise_user ||= :user
    end

    def devise_user_key=(v)
      @devise_user_key = v
    end

    def devise_user_key
      @devise_user_key ||= "#{self.devise_user.to_s}_id".to_sym
    end
  end
end
