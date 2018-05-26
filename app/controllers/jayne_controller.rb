 class JayneController < ApplicationController
   def uptime
     render json: MemeCommands.new(channel: params["channel"]).akm_blade_uptime, status: 200
   end

   def fleta
     render json: MemeCommands.new(channel: params["channel"]).fleta_blade_uptime, status: 200
   end

   def wakeup
     render json: {}, status: :no_content
   end
 end
