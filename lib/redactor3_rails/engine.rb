module Redactor3Rails
  class Engine < Rails::Engine
    isolate_namespace Redactor3Rails

    initializer 'redactor3_devise' do |app|
      ActionController::Base.send :include, Redactor3Rails::Devise
    end
  end
end
