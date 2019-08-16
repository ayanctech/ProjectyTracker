class Project < ApplicationRecord
  belongs_to :user
  has_many :features
  validates :title, presence: true, length: { minimum: 4 }
  accepts_nested_attributes_for :features
end
