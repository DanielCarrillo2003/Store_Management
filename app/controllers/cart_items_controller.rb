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

    def checkout
        sale = Sale.new(sale_params.merge(date_time: Time.current))
        if sale.save
            current_user.cart_items.each do |cart_item|
                product = cart_item.product
                sale_item = SaleItem.create(user: current_user, product: product, quantity: cart_item.quantity, sale: sale)
                if sale_item.persisted?
                    product.update(on_sale: product.on_sale - cart_item.quantity)
                    cart_item.destroy
                else
                    flash.now[:notice] = 'Ocurrió un error al crear SaleItem'
                    puts('Ocurrió un error al crear SaleItem')
                    render partial: 'cart_content', status: :unprocessable_entity
                    return
                end
            end
            SalesMailer.send_receipt(current_user.username, current_user.email).deliver_now
            flash[:notice] = 'Compra realizada'
            render partial: 'cart_content'
        else
            flash.now[:notice] = 'Ocurrió un error con la compra'
            render partial: 'cart_content', status: :unprocessable_entity
        end
    end

    private 

    def cart_item_params
        params.require(:cart_item).permit(:product_id, :user_id, :quantity)
    end

    def sale_params 
        params.require(:cart_item).permit(:user_id, :total_amount)
    end
    
end
