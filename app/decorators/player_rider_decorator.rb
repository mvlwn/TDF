# encoding: utf-8
class PlayerRiderDecorator < Draper::Decorator

  delegate_all
  decorates_association :rider
  decorates_association :substitute_rider


end
