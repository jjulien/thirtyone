class CalendarController < ApplicationController
  before_action :authorize_calendar
  before_action :populate_work_schedules, only: [:index, :person, :day]

  private
  def populate_work_schedules
    @work_schedules = WorkSchedule.all
  end

  def authorize_calendar
    authorize :calendar
  end
end