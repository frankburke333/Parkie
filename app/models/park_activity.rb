class ParkActivity < ApplicationRecord
  belongs_to :park
  belongs_to :activity
  has_many :subscriptions
  has_many :events

  validates :park_id, :activity_id, presence: true
end
