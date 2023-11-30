class ProductsController < ApplicationController
    def index 
        if params[:search].present?
            @products = Product.search_by_fields(params[:search])
        else
            @products = Product.all
        end
    end

    def new
        @product = Product.new
        @categories = Category.all
        @suppliers = Supplier.all
    end

    def create
        @categories = Category.all
        @suppliers = Supplier.all
        @product = Product.new(product_params)
        if @product.save
            flash[:notice] = 'El producto ha sido agregado con exito'
            redirect_to personal_products_path
        else 
            flash.now[:notice] = "El producto no se pudo agregar, intente de nuevo"
        end
    end

    def edit
        @categories = Category.all
        @suppliers = Supplier.all
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            flash[:notice] = 'El producto ha sido actualizado con exito'
            redirect_to personal_products_path
        else
            flash.now[:notice] = "Error al actualizar el producto, intente de nuevo"
        end
    end 
 

    def destroy
        @product = Product.find(params[:id])
        puts(@product)
        puts(params[:id])
        if @product.destroy
            flash[:notice] = 'El producto ha sido eliminado con exito'
            redirect_to personal_products_path
        else
            flash.now[:notice] = "El producto no se pudo eliminar, intente de nuevo"
        end
    end

    def products_to_buy 
        @categories = Category.all
        @products = Product.all
        @cart_item = CartItem.new
    end

    private

    def product_params
        params.require(:product).permit(:name, :description, :location, :price, :category_id, :supplier_id, :image)
    end
end