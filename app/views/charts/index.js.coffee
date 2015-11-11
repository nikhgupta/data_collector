el = $('#sensor-charts .chart')
<% if @filters[:series].present? %>
html = '<%= j line_chart(@data, library: { chart: { width: 1200 } }, min: nil, max: nil) %>'

$("#period_start").val '<%= @filters[:period_start] %>' if $("#period_start").val() is ""
$("#period_end").val '<%= @filters[:period_end] %>' if $("#period_end").val() is ""

<% @filters[:series].each do |series| %>
$("#series option[value='<%= series %>']").attr("selected", "selected")
<% end %>

<% @filters[:sensors].each do |sensor| %>
$("#sensors option[value='<%= sensor %>']").attr("selected", "selected")
<% end %>

<% if @filters[:message].present? %>
$('#sensor-charts .message').html('<%= @filters[:message] %>')
$('#sensor-charts .message').addClass 'warning'
$('#sensor-charts .message').slideDown()
<% else %>
$('#sensor-charts .message').slideUp()
$('#sensor-charts .message').removeClass 'warning error'
<% end %>

<% else %>
$('#sensor-charts .message').html('<%= @filters[:message] %>')
$('#sensor-charts .message').addClass 'error'
$('#sensor-charts .message').slideDown()
<% end %>

el.fadeOut 'fast', -> el.html(html) and el.fadeIn('slow')
