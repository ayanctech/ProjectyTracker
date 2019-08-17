class Project < ApplicationRecord
  belongs_to :user
  has_many :features
  has_many :comments
  validates :title, presence: true, length: { minimum: 4 }
  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :comments
end
