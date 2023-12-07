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
            flash.now[:error] = "Hubo un error al intentar registrar un producto, verifique que los datos ingresados sean correctos."
            render :new, status: :unprocessable_entity
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
        if @product.destroy
            flash[:notice] = 'El producto ha sido eliminado con éxito'
            redirect_to personal_products_path
        else
            flash.now[:notice] = "El producto no se pudo eliminar, intente de nuevo"
        end
    end

    def show_product_details_to_buyer 
        @product = Product.find(params[:id])
        puts(@product.category.name )
        @cart_item = CartItem.new
    end
    

    def products_to_buy 
        if params[:search].present?
            @products = Product.search_by_fields(params[:search])
            if params[:category].present?
                @category = Category.find_by(name: params[:category])
                @products = @products.where(category: @category)
            end
        else
            @products = Product.all
            if params[:category].present?
                @category = Category.find_by(name: params[:category])
                @products = @products.where(category: @category)
            end
        end
        @categories = Category.all
        @cart_item = CartItem.new
        @cart_items = current_user.cart_items
        @cart_total = calculate_total(@cart_items)
    end

    def total
        @cart_items = current_user.cart_items
        @total = calculate_total(@cart_items)
        render json: { total: @total }
    end

    private

    def calculate_total(cart_items)
        cart_items.sum { |item| item.product.price * item.quantity }
    end

    def product_params
        params.require(:product).permit(:name, :description, :location, :price, :category_id, :supplier_id, :image)
    end
end