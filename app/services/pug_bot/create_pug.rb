module PugBot
  class CreatePug
    def initialize(attributes, event)
      @attributes = attributes
      @event = event
    end

    def run!
      unfilled_pug = get_unfilled_pug

      if unfilled_pug
        create_user(unfilled_pug)
        unfilled_pug
      else
        pug = create_pug
        create_user(pug)
        channels = create_voice_channels(pug)
        create_channel_records(channels, pug)

        pug
      end
    end

    private

    attr_accessor :attributes, :event

    def get_unfilled_pug
      Pug.joins(:pug_members).select("pugs.*").where(pug_type: attributes[:pug_type], region: attributes[:region]).group("pugs.id").having("count(pug_members.id) < 12").first
    end

    def create_pug
      Pug.create!(pug_type: attributes[:pug_type], region: attributes[:region])
    end

    def create_user(pug)
      PugMember.create!(
        pug_id:      pug.id,
        captain:     attributes[:captain],
        battlenet:   attributes[:battlenet],
        ping_string: attributes[:ping_string],
        discord_tag: attributes[:discord_tag],
      )
    end

    def create_voice_channels(pug)
      ["Blue", "Red"].map do |color|
        name = "#{pug.id}-#{pug.region}-#{pug.pug_type}-#{color}"

        event.server.create_channel(
          name,
          2,
          parent: 440427531183587338
        )
      end
    end

    def create_channel_records(channels, pug)
      channels.each do |channel|
        ChannelRecord.create!(
          pug_id: pug.id,
          channel_uuid: channel.id,
          channel_name: channel.name
        )
      end
    end
  end
end
