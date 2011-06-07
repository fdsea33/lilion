class ApplicationController < ActionController::Base
  before_filter :authorize

  PUBLIC_ACTIONS = [
                    "sessions#new",
                    "sessions#create",
                    "sessions#destroy",
                    "petitions#index",
                    "petitions#show",
                    "signatures#index",
                    "signatures#new",
                    "signatures#create",
                    "signatures#certify"
                    ]

  protect_from_forgery

  def current_user()
    return nil unless session[:current_user_id]
    @current_user ||= Person.find(session[:current_user_id])
    return @current_user
  end

  protected

  def render_form(options={})
    operation = action_name.to_sym
    operation = (operation==:create ? :new : operation==:update ? :edit : operation)
    partial    = options[:partial]||'form'
    render(:template=>options[:template]||"forms/#{operation}", :locals=>{:operation=>operation, :partial=>partial, :options=>options})
  end

  def authorize()
    I18n.locale = :fra
    return if PUBLIC_ACTIONS.include? "#{controller_name}##{action_name}"
    unless current_user
      redirect_to root_url
    end
  end

end
