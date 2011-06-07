module ApplicationHelper

  def current_user
    self.controller.current_user
  end

  def tl(*args)
    I18n.translate("labels."+args[0].to_s, *args[1..-1])
  end

  def title
    I18n.translate("actions.#{controller_name}.#{action_name}")
  end

end
