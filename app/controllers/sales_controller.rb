class SalesController < ApplicationController
    def index
        @sales = current_user.sales
    end

    def sale_details
        @sale = Sale.find(params[:id])
        @total = @sale.total_amount
    end
end