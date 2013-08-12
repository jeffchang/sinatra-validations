require 'chronic'

get '/' do
  @message = session[:message]
  session[:message] = nil
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  @organizer = session[:organizer]
  @email = session[:email]
  erb :create_event
end

post '/events/create' do
  params[:date] = Chronic.parse(params[:date] + " " + params[:time])
  params.delete(:time)
  session[:message] = []
  session[:organizer] = params[:organizer_name]
  session[:email] = params[:organizer_email]
  event = Event.new(params)
  unless params[:date] || params[:date] < Time.now
    if event.valid?
      event.save
      session[:message] << "Event successfully created!  Thanks for using your friendly neighborhood Event Scheduler!"
    end
  else
    session[:message] << "Your date is invalid!  Note that you can't create events in the past."
  end
  session[:message] << "Your event title is already in use.  Try again!" unless event.valid?
  redirect '/'
end
