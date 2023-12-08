class Movement < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_by_fields,
    against: [:product_name, :movement, :quantity_affected, :day, :month, :year],
    using: {
        tsearch: {
            prefix: true,
            any_word: true,       
            normalization: 2
        }
    }

    after_create :set_date_values

    private

    def set_date_values
        date_value = created_at.inspect
        day_date_value = date_value[0..2]
        day_value = case day_date_value
        when "Mon"
            "Lunes"
        when "Tue"
            "Martes"
        when "Wed"
            "Miercoles"
        when "Thu"
            "Jueves"
        when "Fri"
            "Viernes"
        when "Sat"
            "Sabado"
        when "Sun"
            "Domingo"
        else
            "Unknown day"
        end
    
        self.day = day_value
        self.month = case created_at.month
        when 1
            "Enero"
        when 2
            "Febrero"
        when 3
            "Marzo"
        when 4
            "Abril"
        when 5
            "Mayo"
        when 6
            "Junio"
        when 7
            "Julio"
        when 8
            "Agosto"
        when 9
            "Septiembre"
        when 10
            "Octubre"
        when 11
            "Noviembre"
        when 12
            "Diciembre"
        end
        self.year = created_at.year.to_s
        save 
    end
end
