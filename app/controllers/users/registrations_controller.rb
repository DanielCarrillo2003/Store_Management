class Users::RegistrationsController < Devise::RegistrationsController
    def create
        build_resource(permit_username_param)
        resource.username = params[:user][:username]
        resource.save
        if resource.persisted?
            set_flash_message! :notice, :signed_up
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
        else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
        end
    end 
   
    private

    def permit_username_param
        params.require(:user).permit(:username, :email, :password, :password_confirmation)  
    end
    
end