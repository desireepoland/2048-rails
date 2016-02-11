class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @games = @current_user.games
  end

  def show
    if params[:id]
      @game = @current_user.games.find_by(id: params[:id])
    else
      @game = @current_user.games.first
    end
    # render json: @game
    render :json => @game.as_json, :status => :ok
  end

  def new
      # binding.pry
    @game = @current_user.games.new(game_params, score: game_params["game_state"]["score"])
  end

  def create

    @game = @current_user.games.new(game_params, score: JSON.parse(game_params["game_state"])["score"])

    if @game.save
      # pass an array of acceptable formats - [:json]
      render json: @game, status: 201
    else
      render json: {error: "Game could not be created."}, status: 422
    end
  end


  def update
    @game = Game.find(game_params[:id])
    if @game.save
      # pass an array of acceptable formats - [:json]
      render json: @game, status: 200
    else
      render json: {error: "Game could not be updated."}, status: 422
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    redirect_to games_path
  end

  private

  def game_params
    params.permit(:id, :game_state, :score)
  end
end
