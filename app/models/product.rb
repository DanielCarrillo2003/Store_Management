class Product < ApplicationRecord
    include PgSearch::Model
    belongs_to :category 
    belongs_to :supplier
    pg_search_scope :search_by_fields,
                against: [:name, :location, :price, :on_sale, :expiration_date],
                associated_against: { category: [:name] },
                using: {
                tsearch: {prefix: true,
                    any_word: true,       
                    normalization: 2    },
                dmetaphone: { any_word: true }
                }
    validates :name, presence: true, uniqueness: {case_sensitive: true}, length: {minimum:10, maximum: 40}
    has_one_attached :image
    validates :image, presence: true
    validates :location, presence: true
    validates :description, presence: true, length: {minimum:40, maximum:500}
    validates :price, presence: true
    validates :category_id, presence: true
    validates :supplier_id, presence: true
    has_many :lots, dependent: :destroy
    has_many :cart_items, dependent: :destroy
    has_many :sale_items, class_name: 'SaleItem', dependent: :destroy
    has_many :sales, through: :sales_items
    def self.ransackable_attributes(auth_object = nil)
        ["category_id", "created_at", "description", "id", "location", "name", "price", "supplier_id", "updated_at", "image"]
    end

    def get_amount_on_sale
        first_lot = lots.order(:expiration_date).first
        amount_on_sale = first_lot ? first_lot.amount : 0
        update(on_sale: amount_on_sale)
    end

    def get_amount_in_stock 
        amount_in_stock = lots.sum(:amount)
        update(in_stock: amount_in_stock)
    end

    def get_lots_in_stock
        quantity_lots = lots.count
        update(lots_in_stock: quantity_lots)
    end 

    def get_expiration_date
        first_lot = lots.order(:expiration_date).first
        lot_expiration_date = first_lot ? first_lot.expiration_date : nil
        update(expiration_date: lot_expiration_date)
    end
end