class User < ApplicationRecord
  has_secure_password
  
  has_many :projects, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
