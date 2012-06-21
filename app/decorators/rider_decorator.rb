# encoding: utf-8
class RiderDecorator < Draper::Base
  decorates :rider

  def name
    model.first_name.to_s + ' ' + model.last_name.to_s
  end

  def price
    h.number_to_euro(model.price * 100000)
  end

  def role
    model.ad_role
  end

  def team_name
    h.truncate(model.team_name, :length => 20)
  end

  def toggle_boolean(field)
    h.link_to h.bool_icon(model.send(field)), h.toggle_rider_path(model, :field => field), :method => :put
  end

end
