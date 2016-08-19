class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }, :storage => :s3

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # after_create :welcome_email

  def welcome_email
    UserMailer.welcome(self).deliver!
  end
end
