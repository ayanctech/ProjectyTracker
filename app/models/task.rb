class Task < ApplicationRecord
  belongs_to :feature
  belongs_to :user
end
