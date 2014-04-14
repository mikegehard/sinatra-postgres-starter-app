require 'sinatra/base'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  enable :sessions

  get '/' do
    session[:email] = nil unless session[:email]
    erb :index, locals: {:email => session[:email]}
  end

  get '/register' do
    erb :register
  end

  post '/' do
    email = params[:Email]
    password = params[:Password]
    id = UserRepository.create(email,password)
    session[:email] = UserRepository.find(id).email
    redirect '/'
  end
end