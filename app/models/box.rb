class Box < ApplicationRecord
  has_many :documents, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
