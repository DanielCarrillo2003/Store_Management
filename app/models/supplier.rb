class Supplier < ApplicationRecord
    has_many :products
    def self.ransackable_attributes(auth_object = nil)
        ["id", "firstname", "name", "enterprise", "phone_nunber"]
    end
end