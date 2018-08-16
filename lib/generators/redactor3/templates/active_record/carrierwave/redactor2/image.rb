class Redactor3Rails::Image < Redactor3Rails::Asset
  mount_uploader :data, Redactor3RailsImageUploader, :mount_on => :data_file_name

  def url_content
    url(:content)
  end
end
