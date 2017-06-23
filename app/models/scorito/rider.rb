module Scorito
  class Rider
    def initialize(data)
      @data = data
    end

    def description
      @data['Description']
    end

    def age
      @data['Age']
    end

    def height
      @data['Height']
    end

    def nationality
      @data['Nationality']
    end

    def nationality_flag_url
      @data['NationalityFlagUrl']
    end

    def weight
      @data['Weight']
    end

    def price
      @data['Price']
    end

    def full_name
      @data['Name']['FullName']
    end

    def first_name
      @data['Name']['FirstName']
    end

    def last_name
      @data['Name']['LastName']
    end

    def short_name
      @data['Name']['NameShort']
    end

    def id
      @data['Id']
    end

    def team_id
      @data['TeamId']
    end

    def team_jersey_url
      @data['TeamJerseyUrl']
    end

    def team_name
      @data['TeamName']
    end

    def rider_type
      @data['RiderType']
    end

    def overall_skill
      qualities('Klassement')
    end

    def time_trial_skill
      qualities('Tijdrijden')
    end

    def sprinting_skill
      qualities('Sprinten')
    end

    def punching_skill
      qualities('Punchen')
    end

    def climbing_skill
      qualities('Klimmen')
    end

    def hills_skill
      qualities('Heuvels')
    end

    def cobblestones_skill
      qualities('Kasseien')
    end

    private

    def qualities(name)
      @data['Qualities'].find{ |q| q['Name'] == name }['Value']
    end
  end
end