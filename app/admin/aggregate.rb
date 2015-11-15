ActiveAdmin.register Aggregate do
  includes :sensor
  actions :all, except: [:new, :show, :create, :edit, :update, :destroy]

  index do
    id_column
    column(:sensor, sortable: :sensor_id)
    column(:length, sortable: :period_length){|ag| ag.period_length.titleize}
    column(:start, sortable: :period_start){|ag| ag.period_start.strftime("%m/%d/%Y %H:%M")}
    column(:end, sortable: :period_end){|ag| ag.period_end.strftime("%m/%d/%Y %H:%M")}
    column :total
    column :mean
    column :std_dev
    column(:created_at, sortable: :created_at){|ag| ag.created_at.strftime("%m/%d/%Y %H:%M")}
  end

  filter :sensor, collection: -> { current_user.sensors }
  filter :period_length, as: :select, collection: DataCollector::DURATIONS.map{|d| ["Per #{d.titleize} Aggregates", d]}
  filter :period_start, input_html: { class: "datetimepicker" }
  filter :period_end, input_html: { class: "datetimepicker" }
  filter :total, as: :numeric
  filter :mean, as: :numeric
  filter :std_dev, as: :numeric
  filter :created_at
end
