class Project < ApplicationRecord
  belongs_to :user
  has_many :features, dependent: :destroy
  has_many :comments, dependent: :destroy


  validates :title, presence: true, length: { minimum: 4 }

  accepts_nested_attributes_for :features, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true

  scope :search, ->(query) { where("title LIKE ? OR description LIKE?", "%#{query}%", "%#{query}%")}

end
