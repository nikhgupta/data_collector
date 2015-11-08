ActiveAdmin.register User do
  # menu false
  permit_params :uuid, :email, :password, :password_confirmation
  # actions :all, except: [:index, :new, :create, :show, :destroy]

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :admin
    column :uuid
    column(:sensors){|user| user.sensors.count}
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :admin
  filter :uuid
  # filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.submit "Update Account"
  end
end
