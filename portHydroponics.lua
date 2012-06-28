local port = minetest.require("__builtin","port")

local plants = {
   tomato = {},
   peas = {},
   habanero = {},
   cyanflower = {},
   magentaflower = {},
   yellowflower = {},
   rubberplant = {short=true, give_on_harvest='hydroponics:rubber'},
   grapes = {permaculture=true},
   coffee = {permaculture=true},
   roses = {give_on_harvest='hydroponics:rosebush'}                          
}

local stages = {
   "seeds",
   "seedlings",
   "sproutlings",
   1,
   2,
   3,
   4
}

for plant,eh in pairs(plants) do
   port("madblocks","hydroponics","hydroponics_"..plant,plant)
   port("madblocks","hydroponics","hydroponics_wild_"..plant,"wild_"..plant)
   for i,stage in ipairs(stages) do
      local name = "hydroponics"
      local n = tonumber(stage)
      if n ~= nil then
         name = name .. '_' .. plant .. stage
      else
         name = name .. '_' .. stage .. '_' .. plant
      end
      local toname = plant..'_'..stage
      port("madblocks","hydroponics",name,toname)
   end
end