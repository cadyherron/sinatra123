require 'sinatra'
require_relative 'lib/tower_of_hanoi'

enable :sessions




get '/' do
  game = TowerOfHanoi.new
  tower_number = game.towers.length
  tower = game.towers
  disk = game.towers.each

  session[:game] = game


  erb :game, locals: {tower_number: tower_number, tower: tower, disk: disk}
end


post '/form' do
  from = params[:from].to_i
  to = params[:to].to_i
  game = session[:game]

  if game.valid_move?(from, to)
    game.move(from,to)
    redirect '/'
  end

end