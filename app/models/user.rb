class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: (8..32), confirmation: true, if: :setting_password?

  has_many :documents
  has_many :boxes

  private 

  def setting_password?
    password || password_confirmation
  end
end
