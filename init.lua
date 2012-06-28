local madblocks_modpath = minetest.get_modpath("madblocks")
math.randomseed(os.time())

SEASON_LENGTH = 1500 -- max tested 1500
WEATHER_CHANGE_INTERVAL = 60
NATURE_GROW_INTERVAL = 700
HYDRO_GROW_INTERVAL = 100
BIRDS = false--true

NATURE_PLANTS = {	'madblocks:hydroponics_cyanflower','madblocks:hydroponics_magentaflower','madblocks:hydroponics_yellowflower',
			'madblocks:dandylions','madblocks:mushroom'}
HYDROPONICS_PLANTS = {
	tomato = {name='tomato',growtype='growtall'},
	peas = {name='peas',growtype='growtall'},
	habanero = {name='habanero',growtype='growtall'},
	cyanflower = {name='cyanflower',growtype='growtall'},
	magentaflower = {name='magentaflower',growtype='growtall'},
	yellowflower = {name='yellowflower',growtype='growtall'},
	rubberplant = {name='rubberplant',growtype='growshort', give_on_harvest='madblocks:rubber'},
	grapes = {name='grapes',growtype='permaculture'},
	coffee = {name='coffee',growtype='permaculture'},            
	roses = {name='roses',growtype='growtall',give_on_harvest='madblocks:rosebush'}                          
}

-- fixed git-120603
dofile (madblocks_modpath .. "/items.lua")
dofile (madblocks_modpath .. "/lights.lua")
dofile (madblocks_modpath .. "/nature.lua")
dofile (madblocks_modpath .. "/hydroponics.lua")
dofile (madblocks_modpath .. "/misc.lua")
dofile (madblocks_modpath .. "/crafts.lua")
dofile (madblocks_modpath .. "/bookmarks.lua")
dofile (madblocks_modpath .. "/multinode.lua")
dofile (madblocks_modpath .. "/nocrafts.lua")		-- new stuff, look in file for giveme names

print('mAdBlOcKs 12.6.12 loaded')

--next: get rid of rubber, rubberplant (5 or 6 nodes), fix crafts
