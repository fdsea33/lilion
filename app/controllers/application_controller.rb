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

  def title(*args)
    @title_params = {} unless @title_params.is_a?({}.class)
    for arg in args
      if arg.is_a?({}.class)
        @title_params.update(arg)
      else
        raise ArgumentError.new("Can only accept hashes")
      end
    end
  end


  def authorize()
    I18n.locale = :fra
    return if PUBLIC_ACTIONS.include? "#{controller_name}##{action_name}"
    unless current_user
      notify(:access_denied, :error)
      redirect_to root_url
      return false
    end
  end

  def notify(message, nature=:information, mode=:next, options={})
    options = mode if mode.is_a? Hash
    mode = :now if nature == :now
    nature = :information if !nature.is_a? Symbol or nature == :now
    notistore = ((mode==:now or nature==:now) ? flash.now : flash)
    notistore[:notifications] = {} unless notistore[:notifications].is_a? Hash
    notistore[:notifications][nature] = [] unless notistore[:notifications][nature].is_a? Array
    notistore[:notifications][nature] << ::I18n.t("notifications."+message.to_s, options)
  end
 
  def notify_now(message, nature=:information, options={})
    options = nature if nature.is_a? Hash
    nature = :information if !nature.is_a? Symbol
    notistore = flash.now
    notistore[:notifications] = {} unless notistore[:notifications].is_a? Hash
    notistore[:notifications][nature] = [] unless notistore[:notifications][nature].is_a? Array
    notistore[:notifications][nature] << ::I18n.t("notifications."+message.to_s, options)
  end

end
