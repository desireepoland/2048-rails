class UsersController < ApplicationController
  def leaderboard
    @users = User.all
    @games = Game.all
    @top_games = Game.order(score: :desc).limit(20)
  end

end
