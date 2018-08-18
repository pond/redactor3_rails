class Redactor3Rails::FilesController < Redactor3Rails.base_controller
  include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token
  before_action :redactor3_authenticate_user!

  def create
    json = {}
    error = nil
    params[:file].each_with_index do |file, i|
      @file = Redactor3Rails.file_model.new
      @file.data = Redactor3Rails::Http.normalize_param(file, request)
      if @file.has_attribute?(:"#{Redactor3Rails.devise_user_key}")
        @file.send("#{Redactor3Rails.devise_user}=", redactor3_current_user)
        @file.assetable = redactor3_current_user
      end
      @file.custom_file_name = file.original_filename

      if @file.save
        json["file-#{i}"] = { id: @file.id, url: @file.url, name: @file.custom_file_name || @file.filename, size: number_to_human_size(@file.data_file_size) }
      else
        error = @file.errors
      end
    end
    if json.empty?
      json = { error: true, message: error.full_messages.to_sentence }
    end
    render json: json
  end

  def index
    json = Redactor3Rails.file_model.where(user_id: redactor3_current_user.id).order('id DESC').map do |file|
      {
        title: file.custom_file_name,
        size: number_to_human_size(file.data_file_size),
        url: file.url,
        id: file.id
      }
    end
    render json: json
  end
end
