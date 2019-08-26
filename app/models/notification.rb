class Notification < ApplicationRecord
  belongs_to :feature, optional: true
  belongs_to :comment, optional: true
end
