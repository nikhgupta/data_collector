#= require active_admin/base
#= require datetimepicker

# jQuery ->
#   $.get '/charts', (data) ->
#     chartEl = $("#sensor-charts")
#     chartEl.css('width', chartEl.parents('.panel').width() * 0.96)
#     myNewChart = new Chart(chartEl.get(0).getContext("2d")).Line(data)

# jQuery ->
#   $("form.formtastic.charts").on 'submit', (e) ->
#     $(".chart").html("<h1>Loading...</h1>")
#     return true

jQuery ->
  $('.datetimepicker').datetimepicker() # mask: true
  $.getScript '/charts.js' if $("#sensor-charts").length > 0
