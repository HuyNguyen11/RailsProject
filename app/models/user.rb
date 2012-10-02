class User < ActiveRecord::Base
   attr_accessible :email, :name, :password, :password_confirmation
   has_secure_password

   before_save{|user| user.name  = user.name.downcase}
   before_save :create_remember_token

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format:{with:VALID_EMAIL_REGEX ,:message => "Email_format_invalid"}, :uniqueness =>  {:case_sensitive => false}
   validates :name, presence: true, :length => {:maximum=>30, :message=> "%{count} character is the maximum allowed"}
   validates :password, presence: true ,:length => { :minimum => 3, :message=>"must have at least %{count} word"}
   validates :password_confirmation, presence: true

   private

   def create_remember_token
   	self.remember_token = SecureRandom.urlsafe_base64
   end


end
