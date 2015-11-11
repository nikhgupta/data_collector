RSpec::Matchers.define :have_highchart do
  match do |page|
    el = @selector.present? ? page.find(@selector) : page
    el.has_selector?(".highcharts-container") && (
      @data_points.nil? || data_points_count == @data_points
    )
  end

  match_when_negated do |page|
    el = @selector.present? ? page.find(@selector) : page
    el.has_no_selector?(".highcharts-container") || (
      !@data_points.nil? && data_points_count != @data_points
    )
  end

  chain :inside do |selector|
    @selector = selector
  end

  chain :with_data_points do |num|
    @data_points = num
  end

  def data_points_count
    el = @selector.present? ? page.find(@selector) : page
    return 0 if el.has_no_selector?(".highcharts-container svg")
    el.all(".highcharts-container svg .highcharts-markers path").count
  end
end
