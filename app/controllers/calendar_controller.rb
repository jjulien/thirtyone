class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)
  end

  def day
    @events = Event.where("start_at >= ? AND start_at < ?",
                          "#{params[:year]}-#{'%02d' % params[:month]}-#{'%02d' % params[:day]} 00:00:00",
                          "#{params[:year]}-#{'%02d' % params[:month]}-#{'%02d' % (params[:day].to_i + 1).to_s} 00:00:00")
    if @events.length == 0
      redirect_to new_event_path(:year => params[:year], :month => params[:month], :day => params[:day])
    end
  end
end
