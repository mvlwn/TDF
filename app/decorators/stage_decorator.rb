class StageDecorator < Draper::Decorator

  delegate_all
  # decorates_association :scores

  def ridden_on(format= :short)
    h.l model.ridden_on, :format => format
  end

  def distance
    h.number_with_precision model.distance.to_s + " km"
  end

end
