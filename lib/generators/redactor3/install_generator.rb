require 'rails/generators'
require 'rails/generators/migration'
module Redactor3
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include ::Rails::Generators::Migration
      desc 'Generates redactor3_rails models, uploaders and migration'

      class_option :orm, :type => :string, :default => 'active_record',
                   :desc => 'ORM (active_record/mongoid)'

      class_option :upload_processor, :type => :string, :default => 'carrierwave',
                   :desc => 'Image processor (carrierwave)'

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        Time.now.strftime('%Y%m%d%H%M%S')
      end

      def mount_engine
        route "mount Redactor3Rails::Engine => '/redactor3_rails'"
      end

      def create_models
        [:asset, :image, :file].each do |filename|
          template "#{generator_dir}/redactor3/#{filename}.rb",
                   File.join('app/models', redactor3_dir, "#{filename}.rb")
        end

        if upload_processor.to_s == 'carrierwave'
          [:image, :file].each do |filename|
            template "#{uploaders_dir}/uploaders/redactor3_rails_#{filename}_uploader.rb",
                     File.join("app/uploaders", "redactor3_rails_#{filename}_uploader.rb")
          end
        end
      end

      def create_migrations
        if orm.to_s == "active_record"
          if ARGV.include?('--devise')
            migration_template "#{generator_dir}/devise_migration.rb", File.join('db/migrate', 'create_redactor3_assets.rb')
          else
            migration_template "#{generator_dir}/migration.rb", File.join('db/migrate', 'create_redactor3_assets.rb')
          end
        end
      end

      protected

      def redactor3_dir
        'redactor3_rails'
      end

      def generator_dir
        @generator_dir ||= [orm, upload_processor].join('/')
      end

      def uploaders_dir
        @uploaders_dir ||= ['base', 'carrierwave'].join('/')
      end

      def orm
        options[:orm] || 'active_record'
      end

      def upload_processor
        options[:upload_processor] || 'carrierwave'
      end

    end
  end
end
