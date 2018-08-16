class Redactor3Rails::File < Redactor3Rails::Asset
  mount_uploader :data, Redactor3RailsFileUploader, :mount_on => :data_file_name

  def url_content
    url(:content)
  end
end
