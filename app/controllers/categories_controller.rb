class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_user_is_personal

    def index 
        if params[:search].present?
            @pagy, @categories = pagy(Category.search_by_fields(params[:search]), items: 10)
        else
            @pagy, @categories = pagy(Category.all, items: 10)
        end
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
        begin
            @category.destroy
            flash[:notice] = 'La categoria ha sido eliminada con exito'
        rescue ActiveRecord::InvalidForeignKey
            flash[:alert] = 'La categoría no puede ser eliminada ya que tiene productos relacionados.'
        ensure
            redirect_to categories_path
        end
    end

    private

    def category_params
        params.require(:category).permit(:name, :description)
    end

    def check_if_user_is_personal
        unless current_user && current_user.personal?
            redirect_to root_path
        end
    end
end