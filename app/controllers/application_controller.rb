class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do
    redirect_to summary_path, :notice => "Deze pagina is niet toegankelijk"
  end

  helper_method :riders_sort_column, :riders_sort_direction

  private

  # Help for CanCan
  def current_ability
    @current_ability ||= Ability.new(current_player)
  end

  def riders_sort_column
    Rider.column_names.include?(params[:sort]) ? params[:sort] : "number, id"
  end

  def riders_sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
  end

  def riders_sort_order
    riders_sort_column + " " + riders_sort_direction
  end


end
