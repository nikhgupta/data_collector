ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  content title: proc{ I18n.t("active_admin.dashboard") } do
    if current_user.sensors.any?
      render partial: "chart_filters"
      div id: "sensor-charts" do
        div class: 'message'
        div class: 'chart'
      end
    else
      div class: "blank_slate_container", id: "dashboard_default_message" do
        span class: "blank_slate" do
          span "No sensors found for your account."
          small "Please, add some sensors to your account first!"
        end
      end
    end
  end
end
