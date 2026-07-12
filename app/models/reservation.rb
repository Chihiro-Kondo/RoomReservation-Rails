class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_at, presence: true
  validates :checkout_at, presence: true
  validates :guest_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to:1 }
  
  validate :checkout_at_after_checkin_at #カスタムバリデーションはsいらない（validate）
  validate :checkin_at_must_be_today_or_later


  def checkout_at_after_checkin_at
    return if checkin_at.blank? || checkout_at.blank?

    if checkout_at < checkin_at
      errors.add(:checkout_at, "はチェックインの翌日以降で入力してください")
    end
  end

  def checkin_at_must_be_today_or_later
    return if checkin_at.blank?
    
    if checkin_at < Date.current
      errors.add(:checkin_at, "は今日以降の日付を入力してください")
    end
  end

  def total_price
    (checkout_at - checkin_at).to_i * room.price * guest_count
  end
end
