ActiveAdmin.register Product do
  config.per_page = 15
  permit_params :name, :description, :location, :price, :category_id, :supplier_id, :image
  
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :category do |product|
      product.category.name if product.category
    end
    column :supplier do |product|
      product.supplier.enterprise if product.supplier
    end
    column :location
    column :price
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :location
      row :price
      row :category do |product|
        product.category.name if product.category
      end
      row :supplier do |product|
        product.supplier.name if product.supplier
      end
      row :image do |product|
        image_tag(product.image.url, height: '200') if product.image.attached?
      end
    end
  end

  filter :name
  filter :description
  filter :location
  filter :price
  filter :category, as: :select, collection: proc { Category.pluck(:name, :id) }
  filter :supplier, as: :select, collection: proc { Supplier.pluck(:name, :id) }

  form do |f|
    f.inputs do
      f.input :name
      f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      f.input :supplier, as: :select, collection: Supplier.all.map { |s| [s.name, s.id] }
      f.input :description
      f.input :image, as: :file, hint: image_tag(f.object.image.variant(resize_to_fill: [150, nil])) if f.object.image.attached?
      f.input :image, as: :file if !f.object.image.attached?
      f.input :location
      f.input :price
    end
    f.actions
  end
end
