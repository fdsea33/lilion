module ApplicationHelper

  def current_user
    self.controller.current_user
  end

  def tl(*args)
    I18n.translate("labels."+args[0].to_s, *args[1..-1])
  end

  def title
    an = action_name
    an = (an == "create" ? "new" : an== "update" ? "edit" : an)
    I18n.translate("actions.#{controller_name}.#{an}", @title_params||{})
  end

  def markup(string)    
    string = "<p>\n"+string.to_s.strip+"\n</p>"
    string.gsub!(/^\ \ \*\ +(.*)\ *$/ , '</p><ul><li>\1</li></ul><p>')
    string.gsub!(/<\/ul><p>\n<\/p><ul>/ , '')
    # raise string.inspect
    string.gsub!(/^\ \ \-\ +(.*)\ *$/ , '</p><ol><li>\1</li></ol><p>')
    string.gsub!(/<\/ol><p>\n<\/p><ol>/ , '')
    string.gsub!(/^\ \ \?\ +(.*)\ *$/ , '</p><dl><dt>\1</dt></dl><p>')
    string.gsub!(/^\ \ \!\ +(.*)\ *$/ , '</p><dl><dd>\1</dd></dl><p>')
    string.gsub!(/<\/dl><p>\n<\/p><dl>/ , '')

    string.gsub!(/^>>>\ +(.*)\ *$/ , '</p><p class="notice">\1</p><p>')
    string.gsub!(/<\/p>\n<p class="notice">/ , '<br/>')
    string.gsub!(/^!!!\ +(.*)\ *$/ , '</p><p class="warning">\1</p><p>')
    string.gsub!(/<\/p>\n<p class="warning">/ , '<br/>')

    string = string.gsub(/\[\[[^\|\]]+(\|[^\]]+)?\]\]/) do |link|
      link = link[2..-3].strip.split("|")
      url = link[0].strip
      url = "http://"+url unless url.match(/^\w+\:\/\//)
      link_to((link[1].blank? ? url : link[1]).strip, url)
    end

    string.gsub!(/([^\:])\/\/([^\s][^\/]+)\/\//, '\1<em>\2</em>')
    string.gsub!(/\'\'([^\s][^\']*)\'\'/, '<code>\1</code>')
    string.gsub!(/\^([^\s][^\^]*)\^/, '<sup>\1</sup>')
    string.gsub!(/\~([^\s][^\~]*)\~/, '<sub>\1</sub>')

    string.gsub!(/\*\*([^\s\*]+)\*\*/, '<strong>\1</strong>')
    string.gsub!(/\*\*([^\s\*][^\*]*[^\s\*])\*\*/, '<strong>\1</strong>')
    string.gsub!(/\n\s*\n/, "</p><p>")
    string.gsub!("</p>\n<p>", "\n")
    string.gsub!(/<p>\s<\/p>/, "")

    string.strip!

    return string.html_safe
  end

  def notification_tag(mode)
    code = ''
    if flash[:notifications].is_a?(Hash) and flash[:notifications][mode].is_a?(Array)
      for message in flash[:notifications][mode]
        code += "<div class='flash #{mode}'><div><h3>#{I18n.t('labels.notifications.'+mode.to_s)}</h3><p>#{h(message).gsub(/\n/, '<br/>')}</p></div></div>"
      end
    end
    return code.html_safe
  end

end
