class SalesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_user_is_buyer

    def index
        @pagy, @sales = pagy(current_user.sales, items: 10)
    end

    def sale_details
        @sale = Sale.find(params[:id])
        @total = @sale.total_amount
    end

    def check_if_user_is_buyer
        unless current_user && !current_user.personal?
            redirect_to root_path
        end
    end
end