class Notification < ApplicationRecord
  belongs_to :feature, optional: true
  belongs_to :comment, optional: true
  #after_create_commit { NotificationBroadcastJob.perform_later(Notification.count)}
end
