class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  validates :email, presence: true,  uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    newEmail = email.strip.downcase
    @user = User.find_by_email(newEmail)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end
