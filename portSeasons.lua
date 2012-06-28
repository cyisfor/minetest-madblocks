local port = minetest.require("__builtin","port")
-- sigh...
local seasons = {
   [1]= "winter",
   [2]= "spring",
   [3]= "summer",
   [4]= "autumn"
}
for season = 1,4,1 do
   if season ~= 3 then
      port("madblocks","nature","grass_"..seasons[season])
      port("madblocks","nature","leaves_"..seasons[season])
   end
end
port("madblocks","nature","cactus_winter")
port("madblocks","nature","ice_flowing")
port("madblocks","nature","ice_source")
port("madblocks","nature","dandylions")
port("madblocks","nature","mushroom")

