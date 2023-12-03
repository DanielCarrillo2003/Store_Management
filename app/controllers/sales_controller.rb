class SalesController < ApplicationController
    def index
        @sales = Sale.all
    end

    def sale_details
        @sale = Sale.find(params[:id])
        @total = @sale.total_amount
    end
end