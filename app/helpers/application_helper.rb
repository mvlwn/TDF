# encoding: utf-8
module ApplicationHelper

  include SkillsHelper

  def controller?(*names)
    names.include?(params[:controller])
  end

  def link_to_player_result(player, selected_player, stage = nil)
    if player == selected_player
      badge, text = ' badge-success', 'Getoond'
    else
      badge, text = '', 'Bekijk'
    end

    if params[:controller] == "summary"
      path = summary_path(:player_id => player.id, :anchor => "ranking")
    elsif params[:controller] == "rankings"
      path = rankings_path(:player_id => player.id, :anchor => "player_ranking")
    else
      path = stage_path(stage, :player_id => player.id, :anchor => "player_ranking")
    end
    link_to text, path, :class => "badge #{badge}"
  end

  def number_to_euro(number)
    number_to_currency(number.to_f, :unit => "€ ", :precision => 0, :separator => ".")
  end

  def bool_icon(bool)
    content_tag("i", "", :class => (bool ? "glyphicon glyphicon-ok" : "glyphicon glyphicon-remove"))
  end

  def badge(content, type, show_badge = false)
    if show_badge
      content_tag("span", content, :class => "badge badge-#{type}")
    else
      content
    end
  end

  def flash_messages
    messages = flash.collect do |key, message|
      case key
        when :notice
          alert_class = 'alert alert-info'
        when :error
          alert_class = 'alert alert-error'
        else
          alert_class = 'alert alert-warning'
      end

      content_tag("div", message, :class => alert_class)
    end
    messages.join("\n").html_safe
  end

  def error_messages_for(model)
    return "" if model.errors.empty?

    messages = model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.template.header",
                      :count => model.errors.count,
                      :model => model.class.model_name.human.capitalize)

    html = <<-HTML
    <div class="alert alert-warning">
      <h3>#{sentence}</h3>
      <p>#{I18n.t("errors.template.body")}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

end
