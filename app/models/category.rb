class Category < ApplicationRecord 
    include PgSearch::Model
    has_many :products
    pg_search_scope :search_by_fields,
    against: [:name, :description],
    using: {
        tsearch: {prefix: true, any_word: true }
    }
end