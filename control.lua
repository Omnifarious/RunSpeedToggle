local function xy_add(p1, p2)
   return {x = p1.x + p2.x,
           y = p1.y + p2.y}
end

local function on_hotkey(event)
   local player = game.players[event.player_index]
   local speed = player.character_running_speed_modifier
   local msg = ""

   if speed == 0 then
      speed = 1.5
      msg = ">"
   elseif (speed > 1.49999) and (speed < 1.50001) then
      speed = 15
      msg = ">>"
   else
      speed = 0
      msg = "0"
   end
   player.character_running_speed_modifier = speed
   player.surface.create_entity(
      {name = "flying-text",
       position = xy_add(player.position,{x=-0.5,y=0.2}),
       text = msg,
       color = {r=1, g=1, b=1}})
end

script.on_event("runspeedtoggle_hotkey", on_hotkey)
