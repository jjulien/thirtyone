class CalendarController < ApplicationController
  def index
    @work_schedules = WorkSchedule.all
  end
end
