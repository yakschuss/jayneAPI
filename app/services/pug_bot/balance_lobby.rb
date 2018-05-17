class BalanceLobby
  def initialize(event)
    @event = event
  end

  def run!
    sort
  end

  def members
    @members ||= PugMember.where(discord_id: discord_ids).order(peak_sr: :asc)
  end

  def discord_ids
    @event.channel.users.select(&:id)
  end

  def sort
    max_number_of_loops_needed.times do |loop|


    end
  end

  def players
    @players = []
  end

  def max_number_of_loops_needed
    members.count - 12 + 1
  end
end
