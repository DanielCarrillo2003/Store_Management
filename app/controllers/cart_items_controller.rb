class CartItemsController < ApplicationController
    before_action :authenticate_user!

    def create
        product = Product.find(params[:product_id])
        @cart_item = current_user.cart_items.find_or_initialize_by(product: product)
        if @cart_item.persisted?
            @cart_item.quantity += params[:quantity].to_i
        else
            @cart_item.quantity = params[:quantity]
        end  
        if @cart_item.save
            flash.now[:notice] = 'Producto agregado al carrito'
            render partial: 'cart_content'
        else 
            flash.now[:alert] = 'No se pudo agregar el producto al carrito'
            render partial: 'cart_content'
        end
    end

    def update
        @cart_item = current_user.cart_items.find(params[:id])
        if @cart_item.update(cart_item_params)
            puts(cart_item_params)
            flash.now[:notice] = 'Cantidad de producto actualizada'
            render partial: 'cart_content'
        else
            puts(cart_item_params)
            flash.now[:alert] = 'No se pudo actualizar la cantidad del producto'
            render partial: 'cart_content'
        end
    end

    def destroy
        @cart_item = current_user.cart_items.find(params[:id])
        @cart_item.destroy
        flash.now[:notice] = 'Producto eliminado del carrito'
        render partial: 'cart_content'
    end

    private 

    def cart_item_params
        params.require(:cart_item).permit(:product_id, :user_id, :quantity)
    end
    
end
