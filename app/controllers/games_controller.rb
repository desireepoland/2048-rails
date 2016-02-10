class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @games = @current_user.games
  end

  def show
    @game = @current_user.games.first
    render json: @game.game_state
  end

  def create
    @game = @current_user.games.new(game_params)
    if @game.save
      # pass an array of acceptable formats - [:json]
      render json: @game, status: 201
    else
      render json: {error: "Game could not be created."}, status: 422
    end
  end

# TODO: change update so it works with game state updating
  def update
        @game = Game.find(params[:id])
        if @game.update_attributes(something: params[:another][:onemore]) # change this
          render 'show', formats: [:json], handlers: [:jbuilder], status: 200 #make sim to above
        else
          render json: {error: "Game could not be updated."}, status: 422
        end
  end

  def destroy
      @game = Game.find(params[:id])
      if @game.destroy
        render json: {}, status: 200
      else
        render json: {error: "Game could not be deleted."}, status: 422
      end
    end

    private

    def game_params
      params.require(:game).permit(:game_state) #add score later
    end
end
