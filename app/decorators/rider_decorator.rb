# encoding: utf-8
class RiderDecorator < Draper::Base
  decorates :rider

  def name
    model.first_name.to_s + ' ' + model.last_name.to_s
  end

  def price
    h.number_to_currency(model.price * 100000, :unit => "€", :precision => 0)
  end

end
