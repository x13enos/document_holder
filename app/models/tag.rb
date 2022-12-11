class Tag < ApplicationRecord
  has_and_belongs_to_many :documents
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
