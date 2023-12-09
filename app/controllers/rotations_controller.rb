class RotationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @rotations = Rotation.all
    end

    def update
        rotation = Rotation.find(params[:id])
        rotation.update(completed: true, completed_at: Time.now, username: current_user.username)
        Product.rotate(rotation.username)
        redirect_to rotations_path, notice: 'Rotación completada'
    end
end