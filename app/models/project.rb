class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :title, presence: true, length: { minimum: 4 }
end
