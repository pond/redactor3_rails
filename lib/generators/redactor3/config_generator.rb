require 'rails/generators'

module Redactor3
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      desc 'Generates redactor3_rails config'

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end


      def create_config
        template 'config.js', File.join('app/assets/javascripts/redactor3_rails', 'config.js')
      end
    end
  end
end
