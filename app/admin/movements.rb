ActiveAdmin.register Movement do
    actions :index, :show
    permit_params :product_name, :quantity_affected, :movement, :created_at
    config.per_page = 15

    index do
        selectable_column
        id_column
        column :product_name
        column :quantity_affected
        column :movement
        column :created_at
        actions
    end

    show do
        attributes_table do
            row :product_name
            row :quantity_affected
            row :movement
            row :created_at
        end
    end
    
    filter :product_name
    filter :quantity_affected
    filter :movement
    filter :created_at
end