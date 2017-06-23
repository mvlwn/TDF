class SyncScoritoRiders

  def initialize
    @scorito_client = Scorito::Client.new
  end

  def sync!(use_cache: true)
    @scorito_client.clear_cache unless use_cache
    @scorito_client.riders.each do |scorito_rider|
      team = Team.find_or_create_by(scorito_id: scorito_rider.team_id)
      team.update!(name: scorito_rider.team_name)

      rider = Rider.find_or_initialize_by(scorito_id: scorito_rider.id)
      rider.update!(
        team_id:              team.id,
        name:                 scorito_rider.full_name,
        last_name:            scorito_rider.last_name,
        first_name:           scorito_rider.first_name,
        short_name:           scorito_rider.short_name,
        price:                scorito_rider.price,
        team_name:            scorito_rider.team_name,
        team_jersey_url:      scorito_rider.team_jersey_url,
        nationality:          scorito_rider.nationality,
        nationality_flag_url: scorito_rider.nationality_flag_url,
        age:                  scorito_rider.age,
        weight:               scorito_rider.weight,
        height:               scorito_rider.height,
        overall_skill:        scorito_rider.overall_skill,
        time_trial_skill:     scorito_rider.time_trial_skill,
        sprinting_skill:      scorito_rider.sprinting_skill,
        punching_skill:       scorito_rider.punching_skill,
        climbing_skill:       scorito_rider.climbing_skill,
        hills_skill:          scorito_rider.hills_skill,
        cobblestones_skill:   scorito_rider.cobblestones_skill,
        description:          scorito_rider.description
      )
    end
  end

end