class CalendarController < ApplicationController
  before_action :authorize_calendar

  def index
    respond_to do |format|
      format.html
      format.json {
        @work_schedules = WorkSchedule.where(start_at: params[:start]..params[:end])

        @json = []

        @work_schedules.each do |work_schedule|
          @json << {
              title: work_schedule.user.person.fullname,
              start: work_schedule.start_at.iso8601,
              end: work_schedule.end_at.iso8601,
              url: url_for(work_schedule)
          }
        end

        render json: @json
      }
    end
  end

  def authorize_calendar
    authorize :calendar
  end
end