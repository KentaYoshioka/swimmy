# coding:utf-8
# 
# save w
#
module Swimmy
  module Command
    class W < Swimmy::Command::Base
      command "w" do |client, data, match|

      now = Time.now

      p self.spreadsheet
 
      case match[:expression] 
      when nil
        client.say(channel: data.channel, text:"#{now.strftime('%Y-%m-%d %H:%M:%S')}　時点での出席者を表示します。\n")
        begin 
          residentlist = Logger.new(spreadsheet).showresident
          rescue Exception => e
            client.say(channel: data.channel, text:"出席者を表示できませんでした.\n")
            raise e
          end 
          client.say(channel: data.channel, text: "#{residentlist}") 

      
        client.say(channel: data.channel, text:"#{now.strftime('%Y-%m-%d %H:%M:%S')}　時点での欠席者を表示します。\n")
        begin 
          absencelist = Logger.new(spreadsheet).showabsence
          rescue Exception => e
            client.say(channel: data.channel, text:"欠席者を表示できませんでした.\n")
            raise e
          end 
          client.say(channel: data.channel, text: "#{absencelist}")
      else
       client.say(channel: data.channel, text: "コマンドが正しくありません")
      end
    end
  

      help do 
        title "w"
        desc "現在の在室者，退室者を表示します"
        long_desc "w:現在の在室者と退室者の名前を全員表示します.\n"
      end

      #######################################################
      ###private inner class
      
      class Logger
        def initialize(spreadsheet)
          @sheet = spreadsheet.sheet("attendance",Swimmy::Resource::Attendance)
        end

        def showresident
          showresident = []
          writtenlist = []
          search_sheet = @sheet.fetch
          for row in search_sheet.reverse
            unless writtenlist.include?(row.member_name)             
                writtenlist.append("#{row.member_name}")
              if row.inout == "hi"
                showresident.append("#{row.member_name}\n")
              else
              end
            else
            end
          end
          return showresident.join
        end #def showresident      

        def showabsence
          writtenlist = []
          absencelist = []
          search_sheet = @sheet.fetch
          counter = 0
          for row in search_sheet.reverse
            unless writtenlist.include?(row.member_name) 
              writtenlist.append("#{row.member_name}")
              if row.inout == "bye"
                absencelist.append("#{row.member_name}\n")
              else
              end
            else
            end

          counter += 1
          if counter == 100
            break
          end

          end
          return absencelist.join
        end #def showabsence
  

      end #def Logger
      private_constant :Logger
       
      

    end #class W
  end #module command
end #Swimmy

