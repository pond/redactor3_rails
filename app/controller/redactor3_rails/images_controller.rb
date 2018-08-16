class Redactor3Rails::ImagesController < ApplicationController
  before_filter :redactor3_authenticate_user!

  def create
    @image = Redactor3Rails.image_model.new

    file = params[:file]
    @image.data = Redactor3Rails::Http.normalize_param(file, request)
    if @image.has_attribute?(:"#{Redactor3Rails.devise_user_key}")
      @image.send("#{Redactor3Rails.devise_user}=", redactor_current_user)
      @image.assetable = redactor_current_user
    end

    if @image.save
      render json: { id: @image.id, url: @image.url(:content) }
    else
      render json: { error: @image.errors }
    end
  end

  private

  def redactor3_authenticate_user!
    if Redactor3Rails.image_model.new.has_attribute?(Redactor3Rails.devise_user)
      super
    end
  end
end
