class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :quantity, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validate :validate_quantity_available

  private 

  def validate_quantity_available
    if product && (quantity.to_i > product.on_sale)
      errors.add(:quantity, "No hay suficientes existencias disponibles")
    end
  end

end
