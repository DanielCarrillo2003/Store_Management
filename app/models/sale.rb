class Sale < ApplicationRecord
    belongs_to :user
    has_many :sale_items
    has_many :products, through: :sale_items
end