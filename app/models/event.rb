class Event < ApplicationRecord
  belongs_to :owner, class_name: "user"
  belongs_to :park_activities
  has_many :eventattendances


  validates :date_time, :user_id, :park_activity_id, presence: true
end
