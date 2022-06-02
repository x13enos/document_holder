class Document < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :box, optional: true
end
