class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @game = Game.find(params[:id])
    render json: @game
  end

  def create
      @game = Game.new(title: params[:story][:title])
      if @game.save
        # pass an array of acceptable formats - [:json]
        render 'show', formats: [:json], handlers: [:jbuilder], status: 201
      else
        render json: {error: "Story could not be created."}, status: 422
      end
    end
end
