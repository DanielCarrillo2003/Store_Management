ActiveAdmin.register User do
  permit_params :email, :username, :phone_number, :rfc, :password, :password_confirmation, :personal

  scope("Personal", default: true) { |scope| scope.where(personal: true) }

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :phone_number
    column :rfc
    column :created_at
    column :personal
    actions
  end

  filter :email
  filter :phone_number
  filter :rfc
  filter :username
  filter :created_a

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :phone_number
      f.input :rfc
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def create
      params[:user][:username] = params[:user][:username]
      params[:user][:personal] = true
      super
    end
  end
end
