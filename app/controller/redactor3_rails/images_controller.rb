class Redactor3Rails::ImagesController < Redactor3Rails.base_controller
  skip_before_action :verify_authenticity_token
  before_action :redactor3_authenticate_user!

  def create
    json = {}
    error = nil
    params[:file].each_with_index do |file, i|
      @image = Redactor3Rails.image_model.new
      @image.data = Redactor3Rails::Http.normalize_param(file, request)
      if @image.has_attribute?(:"#{Redactor3Rails.devise_user_key}")
        @image.send("#{Redactor3Rails.devise_user}=", redactor3_current_user)
        @image.assetable = redactor3_current_user
      end
      if @image.save
        json["file-#{i}"] = { id: @image.id, url: @image.url(:content) }
      else
        error = @image.errors
      end
    end
    if json.empty?
      json = { error: true, message: error.full_messages.to_sentence }
    end
    render json: json
  end

  def index
    json = Redactor3Rails.image_model.where(user_id: redactor3_current_user.id).order('id DESC').map do |image|
      {
        thumb: image.data.thumb.url,
        url: image.url(:content),
        id: image.id
      }
    end
    render json: json
  end
end
