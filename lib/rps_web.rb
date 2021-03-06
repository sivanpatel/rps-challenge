require 'sinatra/base'
require_relative '../lib/game'
require_relative '../lib/player'

class RockPaperScissors < Sinatra::Base

  enable :sessions

  set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    'Hello RockPaperScissors!'
    erb :index
  end

  get '/name' do
    @visitor = params[:name]
    session[:name] = @visitor
    erb :name
  end

  get '/newgame' do
    @visitor = session[:name]
    player_1 = Player.new "#{@visitor}" # changed to local variable
    player_2 = Player.new "computer"
    $game = Game.new player_1, player_2
    $game.winner
    erb :newgame
  end

  post '/newgame' do
    @selection = params[:selection]
    $game.player_1.choice @selection.to_sym # refrenced players from game object
    $game.player_2.choice random_selection
    erb :newgame
  end

  def random_selection
    [:rock, :paper, :scissors].sample
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
