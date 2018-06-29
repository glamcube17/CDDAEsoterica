--require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

  id = "AndiMod",
  version = "2"

}

mods[MOD.id] = MOD

function MOD.on_game_loaded()
  game.add_msg("testign testing is this thing on")

  --LOG.message(MOD.id..".main.on_game_loaded:START")

  

  --LOG.message(MOD.id..".main.on_game_loaded:END")

end

function MOD.on_new_player_created()

  -- LOG.message(MOD.id..".main.on_new_player_created:START")

  MOD.Init()
  MOD.Update()

  -- LOG.message(MOD.id..".main.on_new_player_created:END")

end

function MOD.on_skill_increased()

  -- LOG.message(MOD.id..".main.on_skill_increased:START")

  MOD.Update()

  -- LOG.message(MOD.id..".main.on_skill_increased:END")

end

function MOD.on_minute_passed()

  -- LOG.message(MOD.id..".main.on_minute_passed:START")

  MOD.Update()

  -- LOG.message(MOD.id..".main.on_minute_passed:END")

end

function MOD.on_day_passed()

  -- LOG.message(MOD.id..".main.on_day_passed:START")

  MOD.Update()  

  -- LOG.message(MOD.id..".main.on_day_passed:END")

end







MOD.KinkyTraitEffect = function()
  -- LOG.message(MOD.id..".main.MOD.NudistTraitEffect:START")

  local kinky_effect = efftype_id("kinky")
  local kinky_effect_duration = 3600000 -- TODO: make this variable configurable

  local lewdness = 0
  
  local i = -2
  while(player:i_at(i):display_name() ~= "none") do
    local it = player:i_at(i)
    local flags = it:flags()
    for flag in flags do
      game.add_msg("worn with flag "..flag)
    end
    i = i-1
  end

  for _,body_part in pairs(enums.body_part) do

    --TODO:
      --get a list of worn items
      --check item for LEWD flag
    if (player:wearing_something_on(body_part) == true) then
      game.add_msg("you are wearing clothes")
      lewdness = lewdness+1
    end

  end
  
  local has_kinky_effect = player:has_effect(kinky_effect)

  if (lewdness > 0 and has_kinky_effect == false) then

    player:add_effect(kinky_effect, kinky_effect_duration)
    
    local player_morale = player:get_morale_level()
    local player_morale_delta = 9991 -- TODO: make this variable configurable or implement some smarter formula in `player_morale_new`
    local player_morale_new = player_morale + player_morale_delta
    --(player_morale_new)
    player:update_morale()
    -- LOG.message(player_morale, player_morale_new)

  elseif (lewdness == 0 and has_kinky_effect == true) then

    player:remove_effect(kinky_effect)

  end

  -- LOG.message(MOD.id..".main.MOD.NudistTraitEffect:END|%s", is_naked)

end





  

MOD.Init = function()

  -- LOG.message(MOD.id..".main.MOD.Init:START")

  

  -- LOG.message(MOD.id..".main.MOD.Init:END")

end

MOD.Traits = {

  KINKY = MOD.KinkyTraitEffect
  
}
  
MOD.Update = function()

  -- LOG.message(MOD.id..".main.MOD.Update:START")

  for trait_name,trait_function_name in pairs(MOD.Traits) do

    if (player:has_base_trait(trait_id(trait_name))) then

      trait_function_name()

    end

  end

  -- LOG.message(MOD.id..".main.MOD.Update:END")

end







MOD.on_game_loaded()
