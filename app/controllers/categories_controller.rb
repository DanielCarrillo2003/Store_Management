class CategoriesController < ApplicationController
    def index 
        @categories = Category.all
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = 'La categoria ha sido agregada con exito'
            redirect_to categories_path
        else 
            flash.now[:notice] = "La categoria no se pudo agregar, intente de nuevo"
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:notice] = 'La categoria ha sido actualizada con exito'
            redirect_to categories_path
        else
            flash.now[:notice] = "Error al actualizar la categoria, intente de nuevo"
        end
    end  

    def destroy
        @category = Category.find(params[:id])
        if @category.destroy
            flash[:notice] = 'La categoria ha sido eliminada con exito'
            redirect_to categories_path
        else
            flash.now[:notice] = "La categoria no se pudo eliminar, intente de nuevo"
        end
    end

    private

    def category_params
        params.require(:category).permit(:name, :description)
    end
end