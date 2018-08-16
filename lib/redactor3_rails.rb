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

  mattr_accessor :image_model, :file_model, :devise_user, :image_uploader, :file_uploader
  @@image_model = Redactor3Rails::Image
  @@file_model = Redactor3Rails::File
  @@devise_user = :user
  @@file_uploader = Redactor3RailsFileUploader
  @@image_uploader = Redactor3RailsImageUploader

  def self.devise_user_key
    "#{self.devise_user.to_s}_id".to_sym
  end
end
