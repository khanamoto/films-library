class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # ストレージの設定
  if Rails.env.production?
    # 本番環境ではS3に画像を保存する
    storage :fog
  else
    # 本番環境以外ではローカルに画像を保存する
    storage :file
  end

  # 大きい画像を自動リサイズする
  process resize_to_fit: [500, 500]
  # プロフィール画像のリサイズ
  # version :user_image_thumb do
  #   process resize_to_fit: [140, 140]
  # end

  # 保存ディレクトリを指定する
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 拡張子を制限する
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # 画像サイズを制限する
  def size_range
    0..1.megabytes
  end

  # ファイル名が重複しないようユニーク名にする
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
