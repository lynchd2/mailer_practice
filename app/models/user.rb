class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }, :storage => :s3

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  after_create do 
    welcome_email(self.id)
  end

  def self.welcome_email(whatever)
    user = User.find_by_id(whatever)
    UserMailer.welcome(user).deliver!
  end
  handle_asynchronously :welcome_email
end
