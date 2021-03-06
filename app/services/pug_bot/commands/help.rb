module PugBot
  module Commands
    class Help

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

      def register
        """
        ```
This command pulls you into our system and allows you to be eligible for a spot to play in PUGS.

In order to register, you'll need to provide your battlenet, your peak SR from the last 3 seasons, the region you wish to play in ( this can be changed later! ) and whether you want to be a captain or not.

The format for the command is as follows:

?register YacoTaco#112 2953 NA Captain

Please be sure to speel everythign correctly!
```
"""
      end

      def sub
        """
        ```
This command allows you to claim a single member of the waiting queue.

It selects the person waiting the longest within the SR range that is designated.

Designate the SR of the missing person, or the average SR of the game.

Please be sure to request the sub while in shorthanded team's voice channel. 

The format for the command is as follows:

?sub NA 3000
```
        """
      end

      def change_region
        """
        ```
Allows you to change your registered region.

The format for the command is as follows:

?change-region REGION

Region is what you wish to change TO.
```
        """

      end

      def change_sr
        """
        ```
Allows you to change your registered peak SR, in the event that you managed to climb a little bit!

The format for the command is as follows:

?change-sr SR
```
        """
      end

      def change_bnet
        """
        ```
Allows you to change your registered battlenet, in the event that you're playing on a smurf.

The format for the command is as follows:

?change-sr SR
```
        """
      end

      def clear_lobbies
        """ 
        ```
This command is usable by PUG Staff and Moderators only. It is a cleanup command to remove any unused lobby voice channels.

?clear-lobbies
```
        """
      end

      def waiting
        """
        ```
        This command will tell you who's waiting in the lobby to start a PUG. Sometimes the queue can miss that you joined, so leave and re-enter if that happens!
        ```
        """
      end

      def info
        """
        ```
        This command gives you the registered info in our system.

        If you leave any info out, it'll look for your specific info, but if you add the Discord tag, such as YourNameHerE#3242, it'll look for that person.
        ```
        """
      end

      def need
        """
        ```
This command allows you to send a message to #pug-announcments, requesting a certain amount of players for an average SR.

The format is as follows:

?need <number of players> <region you're in> <avg sr>
        ```
        """
      end

      def all
        """
Here is a list of the available commands for pug-bot:

You can also type ?help <command> for more specific info.

        ```
?register <BATTLENET> <PEAK SR> <REGION> <CAPTAIN(optional)>
?sub <REGION> <SR>
?change-region <REGION>
?change-sr <SR>
?change-bnet <BATTLENET>
?waiting
?info
?need <NUMBER> <REGION> <SR>
?clear-lobbies```
        """
      end

    end
  end
end
