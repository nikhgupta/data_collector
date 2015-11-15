ActiveAdmin.register Sensor do
  includes :user
  actions :all, except: [:new, :show, :create, :edit, :update, :destroy]

  index do
    selectable_column
    id_column
    column :user
    column :uuid
    column :format
    column :length
    column :created_at
  end
end
