local function on_hotkey(event)
   local player = game.players[event.player_index]
   local speed = player.character_running_speed_modifier
   local msg = ""

   if speed == 1 then
      speed = 1.5
      msg = ">"
   elseif (speed > 1.49999) and (speed < 1.50001) then
      speed = 15
      msg = ">>"
   else
      speed = 1
      msg = "1"
   end
   player.surface.create_entity(
      {name = "flying-text",
       position = pos_offset(player.position,{x=-0.5,y=0.2}),
       text = msg,
       color = {r=1, g=1, b=1}})
end

script.on_event("runspeedtoggle_hotkey", on_hotkey)
