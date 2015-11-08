ActiveAdmin.register Sensor do
  includes :user

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
