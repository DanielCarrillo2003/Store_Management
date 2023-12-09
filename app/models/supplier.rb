class Supplier < ApplicationRecord
    include PgSearch::Model
    has_many :products
    pg_search_scope :search_by_fields,
    against: [:name, :firstname, :phone_number, :enterprise],
    associated_against: {
        products: [:name, :description, :location]
    },
    using: {
        tsearch: {prefix: true, any_word: true }
    }
    validates :name, presence: true
    validates :firstname, presence: true
    validates :enterprise, presence: true
    validates :phone_number, presence: true, length: {is: 10}


    def self.ransackable_attributes(auth_object = nil)
        ["id", "firstname", "name", "enterprise", "phone_nunber"]
    end
end