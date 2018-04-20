 class JayneController < ApplicationController
   def uptime
     render json: MemeCommands.akm_blade_uptime(channel: params["channel"]), status: 200
   end
 end
