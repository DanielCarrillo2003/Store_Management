class PagesController < ApplicationController
    def home
        if current_user && current_user.personal
            @rotation_pending = Rotation.where(completed: false).first
        end
        if current_user
            @user = current_user
        end
    end
end