class WorkScheduleController < ApplicationController
  @@date_format = '%Y-%m-%d %H:%M:%S %z'
  @@zone = ' '+ Time.now.strftime('%z')

  def index
    @work_schedules = WorkSchedule.all
  end

  def new
    @work_schedule = WorkSchedule.new
    @work_schedule.start_at=Time.now.change(hour: 8, min: 0)
    @work_schedule.end_at=Time.now.change(hour: 16, min: 0)

    @people = Person.all
  end

  def update
    @edit_work_schedule = WorkSchedule.find(params[:id])
    @edit_work_schedule.staff_id = params[:person_id]
    @edit_work_schedule.start_at = DateTime.strptime(params[:work_schedule][:start_at] + @@zone, @@date_format)
    @edit_work_schedule.end_at = DateTime.strptime(params[:work_schedule][:end_at] + @@zone, @@date_format)
    @edit_work_schedule.note = params[:work_schedule][:note]

    respond_to do |format|
      if @edit_work_schedule.save
        format.html { redirect_to action: 'index' }
      else
        format.html { redirect_to action: 'new' }
      end
    end
  end

  def edit
    @work_schedule = WorkSchedule.find(params[:id])
  end

  def delete

  end

  def show
    @work_schedule = WorkSchedule.find(params[:id])
    @people = Person.all
  end

  def destroy
    @work_schedule=WorkSchedule.all
    @work_schedule.destroy(params[:id])
    redirect_to action: 'index'
  end

  def create
    @work_schedule=WorkSchedule.new()
    @work_schedule.note = params[:work_schedule][:note]
    @work_schedule.start_at = DateTime.strptime(params[:work_schedule][:start_at] + @@zone, @@date_format)
    @work_schedule.end_at = DateTime.strptime(params[:work_schedule][:end_at] + @@zone, @@date_format)

    if params[:person_id] != '' and Person.find(params[:person_id])
      @work_schedule.staff_id = params[:person_id]
      respond_to do |format|
        if @work_schedule.save
          format.html { redirect_to action: 'index' }
        else
          format.html { redirect_to action: 'new', alert: 'Please enter valid staff name' }
        end
      end
    else
      @people = Person.all
      flash[:alert] = 'Please enter valid staff name'
      render action: 'new'
    end
  end
end
