class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = WorkSchedule.event_strips_for_month(@shown_month)
  end

  def day
    @work_schedules = WorkSchedule.where("start_at >= ? AND start_at < ?",
                          "#{params[:year]}-#{'%02d' % params[:month]}-#{'%02d' % params[:day]} 00:00:00",
                          "#{params[:year]}-#{'%02d' % params[:month]}-#{'%02d' % (params[:day].to_i + 1).to_s} 00:00:00")
    @current_date = "#{'%02d' % params[:month]}/#{'%02d' % params[:day]}/#{params[:year]}"
    if @work_schedules.length == 0
      redirect_to new_work_schedule_path(:year => params[:year], :month => params[:month], :day => params[:day])
    end
  end

  def person
    @work_schedules = WorkSchedule.find_all_by_staff_id(params[:person_id])
  end
end
