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
      @trip.users.each do |p|
        unless p.phone.blank?
          number_to_send_to = p.phone
       
          twilio_sid = "AC9eed7fc8a708ddd0404a6d02e467a26e"
          twilio_token = "2acd05d4b8d0aebd6e868be156321b5a"
          twilio_phone_number = "6156175550"
       
          @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
       
          @twilio_client.account.sms.messages.create(
            :from => "+1#{twilio_phone_number}",
            :to => number_to_send_to,
            :body => "#{current_user.name} has joined your Vandy FareShare trip! Email: #{current_user.email unless current_user.email.blank?} Phone: #{current_user.phone unless current_user.phone.blank?}."
          )
        end
      end

      @trip.users << current_user if user_signed_in? 
      redirect_to :back
    end
  end

  def create
    @trip = Trip.new(params[:trip])
    if @trip.save
      flash[:notice] = "Trip created!"

    number_to_send_to = current_user.phone
 
    twilio_sid = "AC9eed7fc8a708ddd0404a6d02e467a26e"
    twilio_token = "2acd05d4b8d0aebd6e868be156321b5a"
    twilio_phone_number = "6156175550"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Your trip has been created on Vandy FareShare! You will receive a text if somebody else joins (with their contact info)."
    )

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
      @trip.users.each do |p|
        unless p.phone.blank?
          number_to_send_to = p.phone
       
          twilio_sid = "AC9eed7fc8a708ddd0404a6d02e467a26e"
          twilio_token = "2acd05d4b8d0aebd6e868be156321b5a"
          twilio_phone_number = "6156175550"
       
          @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
       
          @twilio_client.account.sms.messages.create(
            :from => "+1#{twilio_phone_number}",
            :to => number_to_send_to,
            :body => "#{current_user.name} has left your Vandy FareShare trip :(."
          )
        end
      end      
      @trip.destroy if @trip.users.count == 0
      redirect_to :back
    else
      flash[:error] =  "You have not signed up for this trip!" 
      redirect_to :back
    end
  end

end
