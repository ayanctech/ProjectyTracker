class Feature < ApplicationRecord
  has_one_attached :file
  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
  accepts_nested_attributes_for :notifications, allow_destroy: true

  validates :name, presence: true, length: { minimum: 2 }

end
