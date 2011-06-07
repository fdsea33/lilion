class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to root_url
      return
    end
    reset_session
    render_form
  end

  def create
    if person = Person.authenticate(params[:name], params[:password])
      session[:current_user_id] = person.id
      redirect_to root_url
      return
    end
    render_form
  end

  def destroy
    reset_session
    redirect_to root_url
  end

end
