local madblocks_modpath = minetest.get_modpath("madblocks")
math.randomseed(os.time())

-- fixed git-120603
dofile (madblocks_modpath .. "/items.lua")
dofile (madblocks_modpath .. "/lights.lua")
dofile (madblocks_modpath .. "/misc.lua")
dofile (madblocks_modpath .. "/crafts.lua")
dofile (madblocks_modpath .. "/bookmarks.lua")
dofile (madblocks_modpath .. "/nocrafts.lua")
minetest.require("madblocks","portSeasons")
minetest.require("madblocks","portHydroponics")

print('mAdBlOcKs 12.6.12 loaded')

--next: get rid of rubber, rubberplant (5 or 6 nodes), fix crafts