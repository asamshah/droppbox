class Document < ApplicationRecord
  belongs_to :user
  mount_uploader :file, FileUploader

  validates :name, presence: true
  validates :file, presence: true

  before_create :generate_share_token

  private

  def generate_share_token
    self.share_token = SecureRandom.urlsafe_base64
  end
end