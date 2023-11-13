class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :period_prices, dependent: :destroy
end
