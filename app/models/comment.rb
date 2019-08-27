class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project
  has_many :notifications
  accepts_nested_attributes_for :notifications, allow_destroy: true

  validates :content, presence: true, length: { minimum: 2 }
end
