
-- ***********************************************************************************
--		SEASONAL CHANGES					**************************************************
-- ***********************************************************************************
SEASON_FILE = minetest.get_worldpath()..'/madblocks.season'

local function set_season(t)
    CURRENT_SEASON = t
    -- write to file
    local f = io.open(SEASON_FILE, "w")
    f:write(CURRENT_SEASON)
    io.close(f)
end

local f = io.open(SEASON_FILE, "r")
if f ~= nil then
	CURRENT_SEASON = f:read("*n")
	io.close(f)
else
	print('could not find season file, creating one (setting winter).')
	set_season(1)

end

switch_seasons = function()
	if CURRENT_SEASON == 1 then 
		set_season(2)		-- set to spring
		print('changing to spring')
		minetest.after(SEASON_LENGTH,switch_seasons)
	elseif  CURRENT_SEASON == 2 then 
		set_season(3)		-- set to summer
		print('changing to summer')
		minetest.after(SEASON_LENGTH,switch_seasons)
	elseif  CURRENT_SEASON == 3 then
		set_season(4) 		-- set to autumn
		print('changing to autumn')
		minetest.after(SEASON_LENGTH,switch_seasons)
	elseif  CURRENT_SEASON == 4 then
		set_season(1) 		-- set to winter
		print('changing to winter')
		minetest.after(SEASON_LENGTH,switch_seasons)

	end
end

minetest.after(SEASON_LENGTH,switch_seasons)

minetest.register_chatcommand("season", {
	params = "<season>",
	description = "set the season",
	func = function(name, param)
		if param == 'winter' or param == 'Winter' then set_season(1)
		elseif param == 'spring' or param == 'Spring' then set_season(2)
		elseif param == 'summer' or param == 'Summer' then set_season(3)
		elseif param == 'fall' or param == 'Fall' then set_season(4)
		elseif param == 'pause' or param == 'Pause' then set_season(0)
			minetest.chat_send_player(name, "Season paused.")
			return
		else
			minetest.chat_send_player(name, "Invalid paramater '"..param.."', try 'winter','spring','summer' or 'fall'.")
			return		
		end
		minetest.chat_send_player(name, "Season changed.")
	end,
})


minetest.register_abm({
		nodenames = { "default:dirt_with_grass","madblocks:grass_autumn",'madblocks:grass_winter',"madblocks:grass_spring",
					  'default:leaves','madblocks:leaves_autumn','madblocks:leaves_winter','madblocks:leaves_spring',
					  "default:water_source","default:water_flowing", "default:cactus","default:desert_sand","default:sand","madblocks:desertsand_winter", "madblocks:sand_winter","madblocks:cactus_winter",'madblocks:ice_source','madblocks:ice_flowing' },
		interval = WEATHER_CHANGE_INTERVAL,
		chance = 6,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			if CURRENT_SEASON == 1 then
				if node.name == 'madblocks:grass_autumn' or node.name == 'default:dirt_with_grass' or node.name == 'madblocks:grass_spring' then
					minetest.env:add_node(pos,{type="node",name='madblocks:grass_winter'})
				elseif node.name == 'madblocks:leaves_autumn' or node.name == 'default:leaves' or node.name == 'madblocks:leaves_spring' then
					minetest.env:add_node(pos,{type="node",name='madblocks:leaves_winter'})

				elseif node.name == 'default:desert_sand' then
					above = minetest.env:get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})
					if above ~= nil and above.name == 'air' then
						minetest.env:add_node(pos,{type="node",name='madblocks:desertsand_winter'})
					end
				elseif node.name == 'default:sand' then
					above = minetest.env:get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})
					if above ~= nil and above.name == 'air' then
						minetest.env:add_node(pos,{type="node",name='madblocks:sand_winter'})
					end
				elseif node.name == 'default:cactus' then
					above = minetest.env:get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})
					if above ~= nil and above.name == 'air' then
						minetest.env:add_node(pos,{type="node",name='madblocks:cactus_winter'})
					end
				elseif node.name == 'default:water_source' then
					above = minetest.env:get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})
					if above ~= nil and above.name == 'air' then
						minetest.env:add_node(pos,{type="node",name='madblocks:ice_source'})
					end
				elseif node.name == 'default:water_flowing' then
					above = minetest.env:get_node_or_nil({x=pos.x,y=pos.y+1,z=pos.z})
					if above ~= nil and above.name == 'air' then
						minetest.env:add_node(pos,{type="node",name='madblocks:ice_flowing'})
					end
				end
			elseif CURRENT_SEASON == 2 then
				if node.name == 'madblocks:grass_winter' or node.name == 'madblocks:grass_autumn' or node.name == 'default:dirt_with_grass' then
					minetest.env:add_node(pos,{type="node",name='madblocks:grass_spring'})
				elseif node.name == 'madblocks:leaves_winter' or node.name == 'madblocks:leaves_autumn' or node.name == 'default:leaves' then
					minetest.env:add_node(pos,{type="node",name='madblocks:leaves_spring'})
				elseif node.name == 'madblocks:desertsand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:desert_sand'})
				elseif node.name == 'madblocks:sand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:sand'})
				elseif node.name == 'madblocks:cactus_winter' then
					minetest.env:add_node(pos,{type="node",name='default:cactus'})
				elseif node.name == 'madblocks:ice_source' then
					minetest.env:add_node(pos,{type="node",name='default:water_source'})
				elseif node.name == 'madblocks:ice_flowing' then
					minetest.env:add_node(pos,{type="node",name='default:water_flowing'})
				end
			elseif CURRENT_SEASON == 3 then
				if node.name == 'madblocks:leaves_spring' or node.name == 'madblocks:leaves_winter' or node.name == 'madblocks:leaves_autumn' then
					minetest.env:add_node(pos,{type="node",name='default:leaves'})
				elseif node.name == 'madblocks:grass_spring' or node.name == 'madblocks:grass_winter' or node.name == 'madblocks:grass_autumn' then
					minetest.env:add_node(pos,{type="node",name='default:dirt_with_grass'})
				elseif node.name == 'madblocks:desertsand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:desert_sand'})
				elseif node.name == 'madblocks:sand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:sand'})
				elseif node.name == 'madblocks:cactus_winter' then
					minetest.env:add_node(pos,{type="node",name='default:cactus'})
				elseif node.name == 'madblocks:ice_source' then
					minetest.env:add_node(pos,{type="node",name='default:water_source'})
				elseif node.name == 'madblocks:ice_flowing' then
					minetest.env:add_node(pos,{type="node",name='default:water_flowing'})
				end
			elseif CURRENT_SEASON == 4 then
				if node.name == 'default:leaves' or node.name == 'madblocks:leaves_spring' or node.name == 'madblocks:leaves_winter' then
					minetest.env:add_node(pos,{type="node",name='madblocks:leaves_autumn'})
				elseif node.name == 'default:dirt_with_grass' or node.name == 'madblocks:grass_spring' or node.name == 'madblocks:grass_winter' then
					minetest.env:add_node(pos,{type="node",name='madblocks:grass_autumn'})
				elseif node.name == 'madblocks:desertsand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:desert_sand'})
				elseif node.name == 'madblocks:sand_winter' then
					minetest.env:add_node(pos,{type="node",name='default:sand'})
				elseif node.name == 'madblocks:cactus_winter' then
					minetest.env:add_node(pos,{type="node",name='default:cactus'})
				elseif node.name == 'madblocks:ice_source' then
					minetest.env:add_node(pos,{type="node",name='default:water_source'})
				elseif node.name == 'madblocks:ice_flowing' then
					minetest.env:add_node(pos,{type="node",name='default:water_flowing'})
				end
			end
		end
})

-- ***********************************************************************************
--		BIRDS SPRING/SUMMER				**************************************************
-- ***********************************************************************************
if BIRDS == true then
	local bird = {}
	bird.sounds = {}
	bird_sound = function(p)
				local wanted_sound = {name="bird", gain=0.6}
				bird.sounds[minetest.hash_node_position(p)] = {
					handle = minetest.sound_play(wanted_sound, {pos=p, loop=true}),
					name = wanted_sound.name, }
			end

	bird_stop = function(p)
				local sound = bird.sounds[minetest.hash_node_position(p)]
				if sound ~= nil then
					minetest.sound_stop(sound.handle)
					bird.sounds[minetest.hash_node_position(p)] = nil
				end
			end
	minetest.register_on_dignode(function(p, node)
		if node.name == "madblocks:bird" then
			bird_stop(p)

		end
	end)
	minetest.register_abm({
			nodenames = { "madblocks:leaves_spring",'default:leaves' },
			interval = NATURE_GROW_INTERVAL,
			chance = 200,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local air = { x=pos.x, y=pos.y+1,z=pos.z }
				local is_air = minetest.env:get_node_or_nil(air)
				if is_air ~= nil and is_air.name == 'air' then
					minetest.env:add_node(air,{type="node",name='madblocks:bird'})
					bird_sound(air)
				end
			end
	})
	minetest.register_abm({
			nodenames = {'madblocks:bird' },
			interval = NATURE_GROW_INTERVAL,
			chance = 2,
			action = function(pos, node, active_object_count, active_object_count_wider)
				minetest.env:remove_node(pos)
				bird_stop(pos)
			end
	})
end
-- ***********************************************************************************
--		NATURE_GROW			**************************************************
-- ***********************************************************************************
minetest.register_abm({
		nodenames = { "default:dirt_with_grass",'madblocks:grass_spring' },
		interval = NATURE_GROW_INTERVAL,
		chance = 200,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local air = { x=pos.x, y=pos.y+1,z=pos.z }
			local is_air = minetest.env:get_node_or_nil(air)
			if is_air ~= nil and is_air.name == 'air' then
				local count = table.getn(NATURE_PLANTS)
				local random_plant = math.random(1,count)
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name=NATURE_PLANTS[random_plant]})
			end
		end
})

minetest.register_abm({
		nodenames = NATURE_PLANTS,
		interval = NATURE_GROW_INTERVAL,
		chance = 2,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.env:remove_node({x=pos.x,y=pos.y,z=pos.z})
		end
})

-- ***********************************************************************************
--		SLIMTREES							**************************************************
-- ***********************************************************************************
minetest.register_abm({
		nodenames = { "madblocks:slimtree" },
		interval = 60,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="madblocks:slimtree_wood"})

			minetest.env:add_node({x=pos.x,y=pos.y+3,z=pos.z},{type="node",name="madblocks:slimtree_wood"})			
			minetest.env:add_node({x=pos.x+1,y=pos.y+3,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x-1,y=pos.y+3,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+3,z=pos.z+1},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+3,z=pos.z-1},{type="node",name="default:leaves"})			


			minetest.env:add_node({x=pos.x,y=pos.y+4,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x+1,y=pos.y+4,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x-1,y=pos.y+4,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+4,z=pos.z+1},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+4,z=pos.z-1},{type="node",name="default:leaves"})			


			minetest.env:add_node({x=pos.x,y=pos.y+5,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x+1,y=pos.y+5,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x-1,y=pos.y+5,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+5,z=pos.z+1},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+5,z=pos.z-1},{type="node",name="default:leaves"})			

			minetest.env:add_node({x=pos.x,y=pos.y+6,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x+1,y=pos.y+6,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x-1,y=pos.y+6,z=pos.z},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+6,z=pos.z+1},{type="node",name="default:leaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+6,z=pos.z-1},{type="node",name="default:leaves"})			
		end
})

-- ***********************************************************************************
--		NODES									**************************************************
-- ***********************************************************************************
PLANTLIKE('slimtree','Slimtree Sapling','veg')
PLANTLIKE('bird','Bird','veg')
PLANTLIKE('dandylions','Dandylions','veg')
PLANTLIKE('mushroom','Wild Mushroom','veg')
minetest.register_node("madblocks:slimtree_wood", {
	description = "Slimtree",
	drawtype = "fencelike",
	tile_images = {"madblocks_tree.png"},
	inventory_image = "madblocks_tree.png",
	wield_image = "madblocks_tree.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	drop = 'default:fence_wood',
})
minetest.register_node("madblocks:ice_source", {
	description = "Ice",
	tile_images = {"madblocks_ice.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:ice_flowing", {
	description = "Ice",
	tile_images = {"madblocks_ice.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:leaves_autumn", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = {"madblocks_leaves_autumn.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1, items = {
			{items = {'default:sapling'},	rarity = 20,},
			{items = {'madblocks:leaves_autumn'},}
		}},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("madblocks:leaves_spring", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = {"madblocks_leaves_spring.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1, items = {
			{items = {'default:sapling'},	rarity = 20,},
			{items = {'madblocks:leaves_spring'},}
		}},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("madblocks:grass_spring", {
	description = "Dirt with snow",
	tile_images = {"madblocks_grass_spring.png", "default_dirt.png", "default_dirt.png^madblocks_grass_spring_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_node("madblocks:grass_autumn", {
	description = "Dirt with snow",
	tile_images = {"madblocks_grass_autumn.png", "default_dirt.png", "default_dirt.png^madblocks_grass_autumn_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_node("madblocks:grass_winter", {
	description = "Dirt with snow",
	tile_images = {"madblocks_snow.png", "default_dirt.png", "default_dirt.png^madblocks_grass_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_node("madblocks:leaves_winter", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = {"madblocks_leaves_with_snow.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1, items = {
			{items = {'default:sapling'},	rarity = 20,},
			{items = {'madblocks:leaves_winter'},}
		}},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("madblocks:cactus_winter", {
	description = "Cactus",
	tile_images = {"madblocks_cactus_wsnow_top.png", "madblocks_cactus_wsnow_top.png", "madblocks_cactus_wsnow_side.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("madblocks:sand_winter", {
	description = "Sand with snow",
	tile_images = {"madblocks_snow.png", "default_sand.png", "default_sand.png^madblocks_sand_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:sand',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_node("madblocks:desertsand_winter", {
	description = "Desert Sand with snow",
	tile_images = {"madblocks_snow.png", "default_desert_sand.png", "default_desert_sand.png^madblocks_desertsand_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:desert_sand',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

