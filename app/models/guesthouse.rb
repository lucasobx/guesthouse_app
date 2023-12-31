class Guesthouse < ApplicationRecord
  belongs_to :address, dependent: :destroy, inverse_of: :guesthouse
  belongs_to :user
  has_many :rooms

  validates :brand_name, :corporate_name, :registration_number, :phone_number, :email, presence: true
  validates_presence_of :address
  validates_associated :address
  
  accepts_nested_attributes_for :address

  PAYMENT_METHODS = ['credit_card', 'debit_card', 'pix', 'cash'].freeze
  serialize :payment_method, type: Array, coder: JSON
end
