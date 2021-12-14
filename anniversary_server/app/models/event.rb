class Event < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  validates :title, :frequency, :layout, presence: true

  LAYOUTS = {
    'primary' => 0,
    'important' => 1,
    'minor' => 2
  }.freeze

  def self.order_by_date_part
    Event.all.order(Arel.sql('MONTH(happen_date) - MONTH(NOW()) +  DAY(happen_date) - DAY(NOW())'))
  end

  def days_from_today
    if Time.zone.today < happen_date
      # 日期还没到来
      (happen_date - Time.zone.today).to_i
    else
      # 日期已经到来
      # 算出下一个日期
      next_date = happen_date + frequency.days
      next_date += frequency.days while next_date < Time.zone.today
      (next_date - Time.zone.today).to_i
    end
  end
end
