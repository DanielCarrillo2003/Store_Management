class SuppliersController < ApplicationController
    def index 
        @suppliers = Supplier.all
    end

    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new(supplier_params)
        if @supplier.save
            flash[:notice] = 'El proveedor ha sido registrado con exito'
            redirect_to suppliers_path
        else 
            flash.now[:notice] = "El proveedor no se pudo agregar, intente de nuevo"
        end
    end

    def edit
        @supplier = Supplier.find(params[:id])
    end

    def update
        @supplier = Supplier.find(params[:id])
        if @supplier.update(supplier_params)
            flash[:notice] = 'El proveedor ha sido actualizado con exito'
            redirect_to suppliers_path
        else
            flash.now[:notice] = "Error al actualizar el proveedor, intente de nuevo"
        end
    end 

    def get_products
        @supplier = Supplier.find(params[:id])
        product_id = params[:product_id]
        @products = @supplier.products 
        @lot = Lot.new
        if product_id 
            @product = Product.find(product_id)
            render html: render_to_string(partial: 'form', locals: { lot: @lot, product: @product }), layout: false
        end
    end
    


    def destroy
        @supplier = Supplier.find(params[:id])
        if @supplier.destroy
            flash[:notice] = 'El proveedor ha sido eliminado con exito'
            redirect_to suppliers_path
        else
            flash.now[:notice] = "El proveedor no se pudo eliminar, intente de nuevo"
        end
    end

    private

    def supplier_params
        params.require(:supplier).permit(:name, :firstname,:phone_number,:enterprise)
    end
end 