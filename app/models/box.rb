class Box < ApplicationRecord
  has_many :documents
  belongs_to :user

  validates :name, presence: true
end
