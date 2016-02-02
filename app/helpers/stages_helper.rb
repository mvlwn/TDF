module StagesHelper

  def highlight_teams(text)
    Player.all.each do |player|
      text = text.to_s.gsub(player.team_name, "**#{player.team_name}**")
    end
    text
  end

end
