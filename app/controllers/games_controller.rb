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
        render json: {error: "Game could not be created."}, status: 422
      end
  end

  def update
        @game = Game.find(params[:id])
        if @game.update_attributes(something: params[:another][:onemore])
          render 'show', formats: [:json], handlers: [:jbuilder], status: 200
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
end
