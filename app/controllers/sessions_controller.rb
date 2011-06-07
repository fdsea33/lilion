class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to root_url
      return
    end
    @person = Person.new
    reset_session
  end

  def create
    if person = Person.authenticate(params[:name], params[:password])
      session[:current_user_id] = person.id
      redirect_to root_url
      return
    else
      notify_now :unvalid_user_name_or_password, :error
    end
    render :action=>:new
  end

  def destroy
    reset_session
    redirect_to root_url
  end

end
