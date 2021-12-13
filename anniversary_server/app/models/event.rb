class Event < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  validates :title, :frequency, :layout, presence: true

  LAYOUTS = {
    'primary' => 0,
    'important' => 1,
    'minor' => 2
  }.freeze

  FREEQUENCY = {
    'annually' => 12,
    'monthly' => 1,
    'quarterly' => 3
  }.freeze

  def self.order_by_date_part
    Event.all.order(Arel.sql('MONTH(happen_date) - MONTH(NOW()) +  DAY(happen_date) - DAY(NOW())'))
  end
end
