class ChartsController < ApplicationController

  def index
    @filters = {}
    fetch_chart_data

    if no_data?
      @filters[:message] = "No data points found for the given filters! Ignored and resetted filters."
      params[:sensors] = params[:period_start] = params[:period_end] = params[:period_length] = nil
      fetch_chart_data
    end

    if no_data?
      @filters[:message] = "No data points found for your sensors!"
    else
      timestamps = @data.map{|s| s[:data].keys }.flatten.uniq.map{|t| Time.parse t}
      @filters[:series] = requested_time_periods
      @filters[:period_start] = timestamps.min.strftime("%Y/%m/%d %H:%M")
      @filters[:period_end]   = timestamps.max.strftime("%Y/%m/%d %H:%M")
      @filters[:sensors] = requested_sensor_ids
    end

    request.format = :js if request.xhr?
    respond_to do |format|
      format.js
      format.json { render json: { data: @data, filters: @filters }.to_json }
    end
  end

  private

  def fetch_chart_data
    @data = requested_time_periods.map do |kind|
      time_series_data_for_aggregate(kind, params[:period_start], params[:period_end])
    end
  end

  def no_data?
    @data.all?{|series| series[:data].empty? }
  end

  def time_series_data_for_aggregate(kind, from = nil, to = nil, options = {})
    data = current_user.aggregates.where(sensor_id: requested_sensor_ids)
    data = data.where(period_length: kind)
    data = data.where("period_start >= ?", from) if from.present?
    data = data.where("period_start <= ?", to)   if to.present?
    data = data.pluck(:period_start, :total, :count).group_by(&:first)
    data = data.map do |start, arr|
      total = arr.map{|a| a[1].to_f}.sum
      count = arr.map{|a| a[2].to_f}.sum
      start = (start - start.sec).strftime("%B %d, %Y %H:%M:%S UTC")
      [start, (total/count).round(2)]
    end
    { name: "#{kind}-aggregate".titleize, data: Hash[data] }
  end

  def requested_time_periods
    available = DataCollector::DURATIONS
    requested = params[:series].map{|s| s.strip.downcase} if params[:series].present?
    requested ? (available & requested) : available
  end

  def requested_sensor_ids
    params[:sensors] ? params[:sensors].map(&:to_i) : current_user.sensor_ids
  end
end
