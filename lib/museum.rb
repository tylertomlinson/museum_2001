class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all { |exhibit| patron.interests.include?(exhibit.name) }
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    @exhibits.reduce({}) do |exh_interests, exhibit|
      exh_interests[exhibit] = @patrons.find_all { |patron| patron.interests.include?(exhibit.name) }
      exh_interests
    end
  end

  def ticket_lottery_contestants(interest)
    patrons_by_exhibit_interest.flat_map do | exhibit, patrons|
      patrons.each do | patron |
        if (patron.interests.include? interest.name) && patron.spending_money < interest.cost
        end
      end
    end.uniq
  end

  def draw_lottery_winner(interest)
    ticket_lottery_contestants(interest).name
  end

  def announce_lottery_winner(interest)
    return "#{draw_lottery_winner(interest)} has won the Dead Sea Scrolls exhibit lottery"
  end
end
