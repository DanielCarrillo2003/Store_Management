class SuppliersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_user_is_personal


    def index 
        if params[:search].present?
            @pagy, @suppliers = pagy(Supplier.search_by_fields(params[:search]), items: 10)
        else
            @pagy, @suppliers = pagy(Supplier.all, items: 10)
        end
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
        if params[:search].present?
            @products = @products.search_by_fields(params[:search])
        end
        @lot = Lot.new
        if product_id
            @product = Product.find(product_id)
            render html: render_to_string(partial: 'form', locals: { lot: @lot, product: @product }), layout: false
        end
    end

    def get_movements
        @pagy, @movements = if params[:search].present?
            pagy(Movement.search_by_fields(params[:search]), items: 20)
        else
            pagy(Movement.all, items: 20)
        end
        @movements = @movements.where("year = ?", params[:year]) if params[:year].present?
    end
    
    def destroy
        @supplier = Supplier.find(params[:id])
        begin
            @supplier.destroy
            flash[:notice] = 'El proveedor ha sido eliminado con éxito'
        rescue ActiveRecord::InvalidForeignKey
            flash[:alert] = 'No se puede eliminar el proveedor porque tiene productos relacionados.'
        ensure
            redirect_to suppliers_path
        end
    end

    private

    def supplier_params
        params.require(:supplier).permit(:name, :firstname,:phone_number,:enterprise)
    end

    def check_if_user_is_personal
        unless current_user && current_user.personal?
            redirect_to root_path
        end
    end
end 