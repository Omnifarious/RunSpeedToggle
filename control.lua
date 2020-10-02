local conf_speed1 = setmetatable({}, {
	__index = function(self, id)
		local v = settings.get_player_settings(game.players[id])["runspeeedtoggle-speed1"].value
		rawset(self, id, v)
		return v
	end
})
local conf_speed2 = setmetatable({}, {
	__index = function(self, id)
		local v = settings.get_player_settings(game.players[id])["runspeeedtoggle-speed2"].value
		rawset(self, id, v)
		return v
	end
})
local conf_speed3 = setmetatable({}, {
	__index = function(self, id)
		local v = settings.get_player_settings(game.players[id])["runspeeedtoggle-speed3"].value
		rawset(self, id, v)
		return v
	end
})

script.on_event(defines.events.on_runtime_mod_setting_changed,
                function(event)
                   if not event or not event.setting then
                      return
                   end
                   if event.setting == "runspeeedtoggle-speed1" then
                      conf_speed1[event.player_index] = nil
                   elseif event.setting == "runspeeedtoggle-speed2" then
                      conf_speed2[event.player_index] = nil
                   elseif event.setting == "runspeeedtoggle-speed3" then
                      conf_speed3[event.player_index] = nil
                   end
end)

local function xy_add(p1, p2)
   return {x = p1.x + p2.x,
           y = p1.y + p2.y}
end

local function approx_eq(v1, v2, errscale)
   offset = math.max(math.abs(v1 * errscale), math.abs(v2 * errscale))
   return math.abs(v1 - v2) <= offset
end

local function on_hotkey(event)
   local player = game.players[event.player_index]
   local speed1 = conf_speed1[event.player_index]
   local speed2 = conf_speed2[event.player_index]
   local speed3 = conf_speed3[event.player_index]
   local curspeed = player.character_running_speed_modifier
   local msg = ""

   if approx_eq(curspeed, speed1, 0.000001) then
      curspeed = speed2
      msg = ">"
   elseif approx_eq(curspeed, speed2, 0.000001) then
      curspeed = speed3
      msg = ">>"
   else
      curspeed = speed1
      msg = "0"
   end
   player.character_running_speed_modifier = curspeed
   player.surface.create_entity(
      {name = "flying-text",
       position = xy_add(player.position,{x=-0.5,y=0.2}),
       text = msg,
       color = {r=1, g=1, b=1}})
end

script.on_event("runspeedtoggle_hotkey", on_hotkey)
