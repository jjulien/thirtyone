class WorkScheduleController < ApplicationController
  def index
    @work_schedules = WorkSchedule.all
  end

  def new
    @work_schedule=WorkSchedule.new
    @people=Person.all
    year = params[:year].to_s()
    if year.length > 0
      t=(params[:year].to_s() + '/' + params[:month].to_s() + '/' + params[:day].to_s())
      @work_schedule.start_at = t.to_date
    else
      @work_schedule.start_at=Time.now
      @work_schedule.end_at=Time.now
    end
  end

  def update
    @edit_work_scehdule=WorkSchedule.find(params[:id])
    @edit_work_scehdule.staff_id = params[:person_id]
    @edit_work_scehdule.start_at = DateTime.parse(params[:work_schedule][:date], params[:work_schedule][:start_time])
    @edit_work_scehdule.end_at = params[:work_schedule][:date]
    @edit_work_scehdule.note = params[:work_schedule][:note]

    respond_to do |format|
      if @edit_work_scehdule.save
        format.html { redirect_to action: 'index' }
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
    @work_schedule=WorkSchedule.new()
    @work_schedule.note = params[:work_schedule][:note]
    dateFormat = '%Y-%m-%d %H:%M:%S %z'
    zone = ' '+ Time.now.strftime('%z')
    @work_schedule.start_at = DateTime.strptime(params[:work_schedule][:start_at] + zone, dateFormat)
    @work_schedule.end_at = DateTime.strptime(params[:work_schedule][:end_at] + zone, dateFormat)

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
