# encoding: utf-8
module ApplicationHelper

  def number_to_euro(number)
    number_to_currency(number.to_f, :unit => "€ ", :precision => 0, :separator => ".")
  end

  def bool_icon(bool)
    content_tag("i", "", :class => (bool ? "icon-ok" : "icon-remove"))
  end

  def flash_messages
    messages = flash.collect do |key, message|
      content_tag("div", message, :class => "alert alert-#{key}")
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
