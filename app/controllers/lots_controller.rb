class LotsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_user_is_personal

    def create
        @supplier = Supplier.find(params[:lot][:supplier_id])
        product = params[:lot][:product_id]
        date = params[:lot][:expiration_date]
        amount_registered = params[:lot][:amount]
        @lot = Lot.new(product_id: product, amount: amount_registered, expiration_date: date)
        if @lot.save
            flash[:notice] = 'Se ha registrado un lote con exito'
            redirect_to see_supplier_products_path(@supplier.id)
        else 
            flash[:alert] = 'Hubo un problema al registrar el lote'
            redirect_to see_supplier_products_path(@supplier.id)
        end
    end

    private 

    def lot_params
        params.require(:lot).permit(:product_id, :supplier_id, :expiration_date, :amount)
    end
    
    def check_if_user_is_personal
        unless current_user && current_user.personal?
            redirect_to root_path
        end
    end
end