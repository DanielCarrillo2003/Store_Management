class Lot < ApplicationRecord
    belongs_to :product
    after_create :update_product
    after_destroy :update_product
    validates :expiration_date, presence: true
    validates :amount, presence: true
    private 
    def update_product 
        product.update_inventory_information
    end
end