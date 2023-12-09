ActiveAdmin.register Rotation do
    actions :index, :show
    config.per_page = 15
    permit_params :username, :scheduled_at, :completed_at, :completed
    
    index do
        selectable_column
        id_column
        column :scheduled_at
        column :completed
        column :username
        column :completed_at
        actions
    end

    show do
        attributes_table do
            row :scheduled_at
            row :completed
            row :username
            row :completed_at
        end
    end

    filter :username
    filter :scheduled_at
    filter :completed_at
    filter :completed
end