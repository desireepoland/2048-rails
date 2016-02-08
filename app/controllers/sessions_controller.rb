class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to root_path
  end
end
