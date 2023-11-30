class Lot < ApplicationRecord
    belongs_to :product

    after_create :update_product
    after_destroy :update_product

    private 

    def update_product 
        product.get_amount_on_sale
        product.get_amount_in_stock
        product.get_lots_in_stock
        product.get_expiration_date
    end
end