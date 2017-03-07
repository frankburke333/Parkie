class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @event = Event.new
    @park = Park.find(params[:park_id])
    @activity = Activity.find(params[:activity_id])
  end

  def create
    # @event = Event.new(event_params)
    park_activity = ParkActivity.find_by(park_id: params[:park_id], activity_id: params[:activity_id])
    @event = Event.new
    @park = Park.find(params[:park_id])
    @activity = Activity.find(params[:activity_id])

    @event.owner = current_user
    @event.park_activity = park_activity
    @event.description = params[:event][:description]
    @event.count = params[:event][:count]
    @event.date_time = params[:event][:date_time]

    @event.date_time = DateTime.new(params[:event]["date_time(1i)"].to_i,
                        params[:event]["date_time(2i)"].to_i,
                        params[:event]["date_time(3i)"].to_i,
                        params[:event]["date_time(4i)"].to_i,
                        params[:event]["date_time(5i)"].to_i)

    if @event.save
      if current_user.cell != nil
        event_create_message
      end
      # Subscription.where("park_activity_id = #{@event.park_activity}")
      redirect_to root_url()
    else
      render :new
    end
  end



  def show
    @events = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_url
  end

  def event_params
    params.require(:event).permit(:date_time, :user_id, :park_activity_id, :description, :count)
  end


  def event_create_message
    park = @event.park_activity.park.name
    activity = @event.park_activity.activity.name
    time = @event.date_time
    body = "PARKIE: You've just created a #{activity} event at #{park} for #{time.strftime("%I:%M%p")} !"
    Message.send_message(current_user.cell, body)
  end


end
