module Swimmy
  module Command
    class Say < Swimmy::Command::Base
      POST_SCHEDULE = []

      command "say" do |client, data, match|
    
        client.say(channel:  data.channel, text: "#{match[:expression]}")

        if match[:expression] == nil
          client.say(channel: data.channel, text: help_message("say"))
        end
          
          
      help do
        title "say"
        desc "文字列を発言します．"
        long_desc "say <文字列> - このチャンネルに<文字列>と発言します．\n"
      end
     end

    end # class Say
  end # module Command
end # module Swimmy

