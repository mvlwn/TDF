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

end
