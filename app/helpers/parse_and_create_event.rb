def parse_and_create_event
  event_time = Chronic.parse((params[:date] + " at " + params[:time]))
  params[:datetime] = event_time.strftime("%a, %b %d, %Y at %I:%M %p")
  params.delete_if {|key, value| ["date", "time"].include?(key) }
  session[:message] = []
  session[:organizer] = params[:organizer_name]
  session[:email] = params[:organizer_email]
  event = Event.new(params)
  if !params[:date] && event_time > DateTime.now
    if event.valid?
      event.save
      session[:message] << "Event successfully created!  Thanks for using your friendly neighborhood Event Scheduler!"
    end
  else
    session[:message] << "Your date is invalid!  Note that you can't create events in the past."
  end
  session[:message] << "Your event title is already in use.  Try again!" unless event.valid?
end