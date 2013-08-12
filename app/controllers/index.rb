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
  parse_and_create_event
  redirect '/'
end
