class WorkScheduleController < ApplicationController
  def index
    @work_schedules = WorkSchedule.all
  end

  def new
    @new_work_schedule=WorkSchedule.new
    @people=Person.all
    year = params[:year].to_s()
    if year.length > 0
      t=(params[:year].to_s() + '/' + params[:month].to_s() + '/' + params[:day].to_s())
      @new_work_schedule.start_at = t.to_date
    else
      @new_work_schedule.start_at=(Date.today())
    end
  end

  def update
    @edit_work_scehdule=WorkSchedule.find(params[:id])
    @edit_work_scehdule.staff_id = params[:person_id]
    @edit_work_scehdule.start_at = params[:work_schedule][:start_at]
    @edit_work_scehdule.end_at = params[:work_schedule][:end_at]
    @edit_work_scehdule.note = params[:work_schedule][:note]

    respond_to do |format|
      if @edit_work_scehdule.save
        format.html { redirect_to action: 'index'}
      else
        format.html { redirect_to action: 'new' }
      end
    end
  end

  def edit
    @edit_work_scehdule=WorkSchedule.find(params[:id])
  end

  def delete

  end

  def show
    @work_schedule=WorkSchedule.find(params[:id])
    @people=Person.all
  end

  def destroy
    @work_schedule=WorkSchedule.all
    @work_schedule.destroy(params[:id])
    redirect_to action: 'index'
  end

  def create
    @work_schedule=WorkSchedule.new
    @work_schedule.staff_id = params[:person_id]
    @work_schedule.start_at = params[:work_schedule][:start_at]
    @work_schedule.end_at = params[:work_schedule][:end_at]
    @work_schedule.note = params[:work_schedule][:note]


    respond_to do |format|
      if @work_schedule.save
        format.html { redirect_to action: 'index'}
      else
        format.html { redirect_to action: 'new' }
      end
    end
  end
end
