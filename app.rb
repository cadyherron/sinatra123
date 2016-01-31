require 'sinatra'
require 'sinatra/flash'
require_relative 'lib/tower_of_hanoi'

enable :sessions

helpers do
  def create_towers
    unless session[:towers]
      TowerOfHanoi.new
    else
      TowerOfHanoi.new(session[:towers])
    end
  end

  def save_game(tower_of_hanoi)
    session[:towers] = tower_of_hanoi.towers
  end
end


get '/' do
  tower_of_hanoi = create_towers
  if tower_of_hanoi.win?
    session.clear
  end
  erb :game, locals: { tower_of_hanoi: tower_of_hanoi }
end


post '/form' do
  tower_of_hanoi = create_towers
  from = params[:from].to_i
  to = params[:to].to_i

  if tower_of_hanoi.valid_move?(from, to)
    tower_of_hanoi.move(from, to)
    save_game(tower_of_hanoi)
  else
    flash[:error] = "Invalid move"
  end
  redirect '/'
end