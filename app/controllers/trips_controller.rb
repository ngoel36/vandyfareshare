class TripsController < ApplicationController
  def index
    @trips = Trip.find(:all, order: "time")
    @trip = Trip.new
    @dates = @trips.collect { |t| t.time.to_date }.uniq
  end

  def join
    @trip = Trip.find(params[:id])
    if @trip.users.include?(current_user)
      flash[:error] =  "You have already signed up for this trip!" 
      redirect_to :back
    else
      @trip.users << current_user if user_signed_in? 
      redirect_to :back
    end
  end

  def create
    @trip = Trip.new(params[:trip])
    if @trip.save
      flash[:notice] = "Trip created!"
      @trip.users << current_user if user_signed_in?
    else
      flash[:error] = "Error posting trip."
    end
    redirect_to :back  
  end


  def leave
    @trip = Trip.find(params[:id])
    if @trip.users.include?(current_user)
      @trip.users.delete(current_user) if user_signed_in? 
      @trip.destroy if @trip.users.count == 0
      redirect_to :back
    else
      flash[:error] =  "You have not signed up for this trip!" 
      redirect_to :back
    end
  end

end
