module PugBot
  module Commands
    class HelpCommand

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        if command.nil?
          all
        else
          begin
            self.send(command.gsub("-", "_").to_sym)
          rescue NoMethodError
            "I'm not sure what you're asking. Type ?help to see available commands."
          end
        end
      end 
      private

      attr_accessor :event, :bot

      def command
        arguments[0]
      end

      def join
        """
        ```
The join command adds you as a registered user of the specified PUG.

You will need your Battlenet capitalized and spelled correctly, followed by the region you wish to register for and the type of pug you want to play in. (High SR or mixed SR). You can also add the word 'Captain' at the end, if you wish to volunteer for the Captain role.

?join <Battlenet> <Region> <PugType> <Captain>[optional]

Example: ?join YacoTaco#11402 NA MixedSR Captain

          ```
        """
      end

      def leave
        """
```
The structure for the leave command is as follows:

The ID can be found on the voice channel.

?leave <ID>

```
        """
      end

      def sub
        """
```
If you wish to become a sub for a region/type PUG, you can register for a total of two hours. Pings for subs are on a first come first serve basis. If you miss your ping, you will be passed over and will need to re-register.

The format is as follows:

?sub Battlenet Region PugType

Spelling is important, and so is order!
```
        """
      end

      def sub_request
        """
```
Specify a PUG ID to get the battlenet of a player who has registered for pugs.

They'll receive a DM that you're looking to have them sub!

A certain amount of time to wait for the player to respond is likely, so give them the benefit of the doubt.

If you re-request, it'll take the next available PUG, but again, you should try to give the first sub a chance to come back.

The format is as follows:

?sub-request <ID>
```
        """
      end

      def list_members
        """
        ```
This will give you a current list of players in the PUG.

If you specify an ID, it will get the unfinished PUG for that classification.

If you don't specify AND you're in a PUG, it will get the list for the most recent PUG you're in.

?list-members [optional] <ID>
```
        """
      end

      def list_pugs
        """
        ```
This will give you a current list of all the PUGs that are currently not fully registered.


?list-pugs
```
        """
      end

      def all
        """
       ```
Available Commands:

All commands must be prefixed by #{PugBot::PREFIX}

join <BattleNet> <Region> <PugType> <Captain>[optional] \n
leave <ID> \n
sub <BattleNet> <Region> <PugType>\n
sub-request <ID> \n
list-members [optional] <ID>\n
list-pugs \n
remove \n
clear-pug \n

PugTypes: #{Pug::PUG_TYPES.join(", ")}
Regions: #{Pug::REGIONS.join(", ")}
        ```
        """
      end

      def remove
        """
        ```
This command is usable by PUG staff and Mods only.

It forcibly removes a member of a pug from the registration, if they're afk or banned from joining PUGs.

If you replace the ID with the word 'all' - it will remove all of the selected user's registrations.

?remove DiscordTag [optional]|all] <ID>
```
        """
      end

      def clear_pug
        """
        ```
This command is usable by PUG staff and Mods only.

The ID needed to do this command is the number on the voice channels. Please precise, as this removes all records.

It disbands a PUG grouping and removes the registrations.
It also cleans up the voice channels created for the PUG.

If you type 'old' and then a number, it will remove any pugs from the last <hours>. If you type 'old' and leave off hours, it will default to twenty four hours.

?clear-pug <ID> [optional| 'old' <hours>]
```
        """
      end
    end
  end
end
