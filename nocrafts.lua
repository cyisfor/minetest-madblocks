local like = minetest.require("madblocks","like")("madblocks")
local soundNode = minetest.require("madblocks","sound")("madblocks")

-- ***********************************************************************************
--		NEW METALLIC ITEMS				**************************************************
-- ***********************************************************************************

like.metal('brushedmetal','Brushed Metal',true)
like.metal('yellow_rustedmetal','Yellow Painted Rusted Metal',true)
like.metal('texturedmetal','Textured Metal')
like.metal('metalbulkhead','Metal Bulkhead')
like.metal('stripedmetal','Caution Striped Metal')
like.brick('brownmedistonebrick','Mediterranean Stonebrick (Brown Tones)')

-- ***********************************************************************************
--		RIVEN/MYST (DECO) NODES			**************************************************
-- ***********************************************************************************

soundNode('riven1','Riven Art (1)','signlike')
soundNode('riven2','Riven Art (2)','signlike')
soundNode('riven3','Riven Art (3)','signlike')
like.metal('rivenwood','Riven Wood')
like.metal('rivenwoodblue','Riven Wood (Blue)')
like.metal('rivenstone1','Riven Stone (1)')
like.metal('rivenstone2','Riven Stone (2)')
like.metal('rivenstoneblue','Riven Stone (Blue)')
like.metal('rivenmetal','Riven Rusted Metal')
like.metal('rivenbulkhead','Riven Metal Bulkhead')
like.metal('rivengoldstone1','Riven Gold Stone (1)')
like.metal('rivengoldstone2','Riven Gold Stone (2)')

minetest.register_node("madblocks:rivenbeetle", {
	description = "Sign",
	drawtype = "signlike",
	tile_images = {"madblocks_rivenbeetle.png"},
	inventory_image = "madblocks_rivenbeetle.png",
	wield_image = "madblocks_rivenbeetle.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 10,
	walkable = false,

	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("madblocks:rivendagger", {
	description = "Sign",
	drawtype = "signlike",
	tile_images = {"madblocks_rivendagger.png"},
	inventory_image = "madblocks_rivendagger.png",
	wield_image = "madblocks_rivendagger.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})


minetest.register_tool("madblocks:riventool", {
	description = "Riven Dagger (tool)",
	inventory_image = "madblocks_riventool.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			fleshy={times={[1]=6.00, [2]=3, [3]=1}, uses=10, maxlevel=3},
			cracky={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3},
			crumbly={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3},
			snappy={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3}
		}
	},
})
-- ***********************************************************************************
--		RIVEN/MYST LINKING BOOKS		**************************************************
-- ***********************************************************************************
local linkingbook = {}
linkingbook.sounds = {}
linkingbook_sound = function(p)
	local wanted_sound = {name="linkingbook", gain=1.5}
		linkingbook.sounds[minetest.hash_node_position(p)] = {
			handle = minetest.sound_play(wanted_sound, {pos=p, loop=false}),
			name = wanted_sound.name,
		}

end
local function has_linkingbook_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end
minetest.register_node("madblocks:linkingbook", {
	description = "Linking Book",
	drawtype = "signlike",
	tile_images = {"madblocks_linkingbook.png"},
	inventory_image = "madblocks_linkingbook.png",
	wield_image = "madblocks_linkingbook.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local player = puncher:get_player_name()-- or ""
		local meta = minetest.env:get_meta(pos)
		local stringpos = meta:get_string("text")
		local p = {}
		p.x, p.y, p.z = string.match(stringpos, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then

			teleportee = minetest.env:get_player_by_name(player)
			linkingbook_sound(pos)
			teleportee:setpos(p)
			linkingbook_sound(p)
		end
	end,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "Linking Book")
		-- new material
		meta:set_string("owner", "")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		-- new material
		if not has_linkingbook_privilege(meta, sender) then return end

		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
--		meta:set_string("infotext", '"'..fields.text..'"')
	end,
	
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_linkingbook_privilege(meta, player)
	end,
	
})
minetest.register_node("madblocks:plinkingbook", {
	description = "Private Linking Book",
	drawtype = "signlike",
	tile_images = {"madblocks_plinkingbook.png"},
	inventory_image = "madblocks_plinkingbook.png",
	wield_image = "madblocks_plinkingbook.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local meta = minetest.env:get_meta(pos)
		if not has_linkingbook_privilege(meta, puncher) then return end
		local player = puncher:get_player_name()-- or ""
		local stringpos = meta:get_string("text")
		local p = {}
		p.x, p.y, p.z = string.match(stringpos, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then

			teleportee = minetest.env:get_player_by_name(player)
			linkingbook_sound(pos)
			teleportee:setpos(p)
			linkingbook_sound(p)
		end
	end,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "Linking Book")
		-- new material
		meta:set_string("owner", "")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		-- new material
		if not has_linkingbook_privilege(meta, sender) then return end

		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
--		meta:set_string("infotext", '"'..fields.text..'"')
	end,
	
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_linkingbook_privilege(meta, player)
	end,
	
})

-- ***********************************************************************************
--		PALM TREES							**************************************************
-- ***********************************************************************************
minetest.register_node("madblocks:palmleaves", {
	description = "Rail",
	drawtype = "raillike",
	tile_images = {"madblocks_palmleaves.png", "madblocks_palmleaves_top.png", "madblocks_palmleaves_top.png", "madblocks_palmleaves_top.png"},
	inventory_image = "madblocks_palmleaves.png",
	wield_image = "madblocks_palmleaves.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
})
like.plant('palmtree','Palmtree Sapling','veg')
minetest.register_abm({
		nodenames = { "madblocks:palmtree" },
		interval = 120,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+3,z=pos.z},{type="node",name="madblocks:slimtree_wood"})
			minetest.env:add_node({x=pos.x,y=pos.y+4,z=pos.z},{type="node",name="madblocks:slimtree_wood"})						
			minetest.env:add_node({x=pos.x,y=pos.y+5,z=pos.z},{type="node",name="madblocks:slimtree_wood"})			
			minetest.env:add_node({x=pos.x,y=pos.y+6,z=pos.z},{type="node",name="madblocks:slimtree_wood"})												
			minetest.env:add_node({x=pos.x,y=pos.y+7,z=pos.z},{type="node",name="madblocks:slimtree_wood"})						
			minetest.env:add_node({x=pos.x,y=pos.y+8,z=pos.z},{type="node",name="madblocks:slimtree_wood"})						
			minetest.env:add_node({x=pos.x+2,y=pos.y+8,z=pos.z},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x-2,y=pos.y+8,z=pos.z},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+8,z=pos.z+2},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+8,z=pos.z-2},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+9,z=pos.z},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x+1,y=pos.y+9,z=pos.z},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x-1,y=pos.y+9,z=pos.z},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+9,z=pos.z+1},{type="node",name="madblocks:palmleaves"})			
			minetest.env:add_node({x=pos.x,y=pos.y+9,z=pos.z-1},{type="node",name="madblocks:palmleaves"})			
		end
})

-- ***********************************************************************************
--		HOLO NODES							**************************************************
-- ***********************************************************************************

minetest.register_node("madblocks:holocobble", {
	description = "Holographic Cobblestone",
	tile_images = {"default_cobble.png"},
	is_ground_content = true,
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:holostone", {
	description = "Holographic Stone",
	tile_images = {"default_stone.png"},
	is_ground_content = true,
	walkable = false,
	groups = {cracky=3},
	--drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
