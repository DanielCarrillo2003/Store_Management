class Product < ApplicationRecord
    include PgSearch::Model
    belongs_to :category 
    belongs_to :supplier
    has_one_attached :image
    has_many :lots, dependent: :destroy
    has_many :cart_items, dependent: :destroy
    has_many :sale_items, class_name: 'SaleItem', dependent: :destroy
    has_many :sales, through: :sales_items

    pg_search_scope :search_by_fields,
    against: [:name, :location, :price, :on_sale, :expiration_date],
    associated_against: { category: [:name] },
    using: {
        tsearch: {
            prefix: true,
            any_word: true,       
            normalization: 2
        },
        dmetaphone: { 
            any_word: true 
        }
    }

    scope :products_expiring_this_week, -> {
        where('expiration_date >= ? AND expiration_date <= ?', Date.today, Date.today + 6.days)
    }

    validates :name, presence: true, uniqueness: {case_sensitive: true}, length: {minimum:10, maximum: 40}
    validates :image, presence: true
    validates :location, presence: true
    validates :description, presence: true, length: {minimum:40, maximum:500}
    validates :price, presence: true
    validates :category_id, presence: true
    validates :supplier_id, presence: true

    after_create :record_creation_movement
    after_update :record_update_movement
    before_destroy :record_deletion_movement

    def self.ransackable_attributes(auth_object = nil)
        ["category_id", "created_at", "description", "id", "location", "name", "price", "supplier_id", "updated_at", "image"]
    end

    def update_inventory_information
        first_lot = lots.order(:expiration_date).first
        amount_on_sale = first_lot ? first_lot.amount : 0
        amount_in_stock = lots.sum(:amount) - amount_on_sale
        quantity_lots = lots.count - 1
        lot_number = first_lot ? first_lot.id : nil
        lot_regis_date = first_lot ? first_lot.created_at : nil
        lot_expiration_date = first_lot ? first_lot.expiration_date : nil
        update(
            on_sale: amount_on_sale,
            in_stock: amount_in_stock,
            lots_in_stock: quantity_lots,
            lot_on_sale_number: lot_number,
            lot_on_sale_registration_date: lot_regis_date,
            expiration_date: lot_expiration_date
        )
    end

    def self.rotate(username)
        products_to_rotate = where('on_sale = 0 OR expiration_date <= ?', 1.week.from_now)
        products_to_rotate.each do |product|
            lots_to_delete = product.lots.where('expiration_date <= ?', 1.week.from_now)
            lots_to_delete.destroy_all if lots_to_delete.present?
            next_lot = product.lots.order(:expiration_date).first
            if next_lot
                product.update(
                on_sale: next_lot.amount,
                in_stock: product.lots.sum(:amount) - next_lot.amount,
                lots_in_stock: product.lots.count - 1,
                expiration_date: next_lot.expiration_date
                )
            else
                product.update(on_sale: 0, expiration_date: nil)
            end
        end
    end

    def record_selling_movement(quantity)
        Movement.create(product_name: name, quantity_affected: quantity, movement: 'Venta')
    end

    private

    def record_creation_movement
        Movement.create(product_name: name, quantity_affected: 1, movement: 'Creación')
    end

    def record_update_movement
        Movement.create(product_name: name, quantity_affected: 1, movement: 'Edición')    
    end
    
    def record_deletion_movement
        Movement.create(product_name: name, quantity_affected: 1, movement: 'Eliminación')
    end
end