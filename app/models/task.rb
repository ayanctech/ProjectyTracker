class Task < ApplicationRecord
  belongs_to :feature
  belongs_to :user

  validates :name, presence: true, length: { minimum: 4 }
end
