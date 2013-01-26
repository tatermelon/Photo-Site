class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user
  
  validates :comment, :presence => true
  
  def validate_comment
    if (comment == "")
      errors.add(:comment, "Cannot be empty")
    end
  end
  
  validate :validate_comment
  
end
