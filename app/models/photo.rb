class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tags
  
  def validate_photo
    if (file_name == "")
      errors.add(:file_name, "Cannot be empty")
    end
  end
  
  validate :validate_photo
end
