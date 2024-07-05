class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded
  def extension_whitelist
    %w(jpg jpeg gif png pdf txt doc docx xls xlsx)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded
  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :save_content_type_in_model

  def save_content_type_in_model
    model.content_type = file.content_type if file.content_type
  end
end