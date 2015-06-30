class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_mailer_host

  # Patch CanCan
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do
    redirect_to summary_path, :notice => "Deze pagina is niet toegankelijk"
  end

  helper_method :riders_sort_column, :riders_sort_direction, :race_started?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :team_name]
  end

  # Help for CanCan
  def current_ability
    @current_ability ||= Ability.new(current_player)
  end

  def riders_sort_column
    Rider.column_names.include?(params[:sort]) ? params[:sort] : "number ASC, id"
  end

  def riders_sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
  end

  def riders_sort_order
    riders_sort_column + " " + riders_sort_direction
  end

  def set_mailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end
  
  def race_started?
    Time.now > Player::MAX_EDIT_TIME
  end

  private

  def sort_players_by_stage_points(players, stage)
    players.each do |player|
      player.sorted_points = player.stage_points(stage)
    end
    players.sort_by{ |player| player.sorted_points }.reverse
  end

  def sort_riders_by_stage_points(riders, stage)
    riders.each do |rider|
      rider.sorted_points = rider.stage_points(stage).to_i
    end
    riders.select{ |rider| rider.sorted_points > 0 }.sort_by{ |rider| rider.sorted_points }.reverse
  end


end
