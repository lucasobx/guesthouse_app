class PeriodPrice < ApplicationRecord
  belongs_to :room

  validate :validate_date_range

  private

  def validate_date_range
    return if PeriodPrice.where(room_id: room_id)
                         .where.not(id: id)
                         .where("start_date < ? AND end_date > ?", end_date, start_date)
                         .empty?

    errors.add(:base, "O período não pode se sobrepor com outro existente.")
  end
end
