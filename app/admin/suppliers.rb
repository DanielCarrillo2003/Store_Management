ActiveAdmin.register Supplier do
  permit_params :name, :firstname, :phone_number, :enterprise

  index do
    selectable_column
    id_column
    column :name
    column :firstname
    column :phone_number
    column :enterprise
    actions
  end
  
  filter :name
  filter :firstname
  filter :enterprise

  form do |f|
    f.inputs do
      f.input :name
      f.input :firstname
      f.input :phone_number
      f.input :enterprise
    end
    f.actions
  end
  
end
