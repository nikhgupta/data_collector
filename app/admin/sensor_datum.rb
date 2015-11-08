ActiveAdmin.register SensorDatum do
  # actions :all, except: [:new, :edit, :create, :update]
  index do
    selectable_column
    id_column
    column :sensor
    column(:data_time, sortable: :data_time){|sd| sd.data_time.strftime("%m/%d/%Y %H:%M")}
    column :data_value
    column(:created_at, sortable: :created_at){|sd| sd.created_at.strftime("%m/%d/%Y %H:%M")}
  end

  filter :sensor
  # filter :data_time, as: :string, input_html: { class: "datetimepicker" }
  filter :data_value, as: :numeric
  filter :created_at
end
