class LotsController < ApplicationController
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
            flash.now[:notice] = "Ha ocurrido un error al registrar el lote, intente de nuevo"
        end
    end

    private 

    def lot_params
        params.require(:lot).permit(:product_id, :supplier_id, :expiration_date, :amount)
    end
    
end