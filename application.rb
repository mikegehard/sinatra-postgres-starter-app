require 'sinatra/base'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    erb :index, locals: {:email => nil}
  end

  get '/register' do
    erb :register
  end

  post '/' do
    email = params[:Email]
    password = params[:Password]
    UserRepository.create(email,password)
    erb :index, locals:{:email => email}
  end
end