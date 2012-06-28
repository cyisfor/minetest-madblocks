local like = minetest.require("madblocks","like")("madblocks")

-- ***********************************************************************************
--		STANDARD DEFS						**************************************************
-- ***********************************************************************************
like.brick('bluecyanbrick', 'Blue-Cyan Odd Brick')
like.brick('magentabrick','Magenta Brick')
like.brick('greenbrick','Green Brick')
like.brick('blackbrick','Black Brick')
like.brick('bluebrick','Blue Brick')
like.brick('yellowbrick','Yellow Brick')
like.brick('brownbrick','Brown Brick')
like.brick('cyanbrick','Cyan Brick')
like.brick('oddbrick','Oddly Coloured Brick')
like.brick('mossystonebrick','Mossy Stone Brick')
like.brick('culturedstone','Cultured Stone')
like.brick('marblestonebrick','Marble Stone Brick')
like.brick('shinystonebrick','Sand-Blasted Stone Brick')
like.brick('cinderblock','Cinderblock')
like.brick('blackstonebrick','Black Stonebrick')
like.brick('roundstonebrick','Round Stonebrick')
like.brick('slimstonebrick','Slim Stonebrick')
like.brick('greystonebrick','Grey Stonebrick')
like.brick('medistonebrick','Mediterranean Stonebrick')
like.brick('whitestonebrick','White Stonebrick')
like.brick('cement','Cement')
like.brick('countrystonebrick','Country Stonebrick')
like.brick('asphalte','Asphalte')
like.wood('woodshingles','Wood Shingles')
like.wood('magentawood','Magenta Stained Wood',true)
like.wood('bluewood','Blue Stained Wood',true)
like.wood('blackwood','Black Stained Wood',true)
like.wood('yellowwood','Yellow Stained Wood',true)
like.wood('cyanwood','Cyan Stained Wood',true)
like.wood('greenwood','Green Stained Wood',true)
like.wood('redwood','Red Stained Wood',true)
like.wood('dye_cyan','Cyan Dye')
like.wood('dye_magenta','Magenta Dye')
like.wood('dye_yellow','Yellow Dye')
like.wood('dye_red','Red Dye')
like.wood('dye_blue','Blue Dye')
like.wood('dye_green','Green Dye')
like.wood('dye_black','Black Dye')
like.sign('park')
like.sign('cliff')
like.sign('interdit')
like.sign('montreal')
like.sign('420')
like.sign('chicken')
like.sign('obscene')
like.sign('cafe',{light=7})
like.sign('drpepper')
like.sign('dangermines')
like.sign('hucksfoodfuel')
like.sign('enjoycoke')
like.plant('flowers1','Flower Arrangement #1','veg')
like.plant('flowers2','Flower Arrangement #2','veg')
like.plant('hangingflowers','Hanging Flower Basket','cri')
like.plant('stool','Bar Stool','cri',true)
like.plant('gnome','Garden Gnome','cri')
like.plant('statue','Statuette','cri')
like.plant('gargoyle','Gargoyle','cri')
like.plant('wine','Wine Bottle','eat',1)
like.plant('coffeecup','Coffee Cup','eat',2)

-- ***********************************************************************************
--		ASSORTED DEFS						**************************************************
-- ***********************************************************************************

minetest.register_node("madblocks:drum", {
	description = "Drum",
	drawtype = 'plantlike',
	tile_images = {"madblocks_drum.png"},
	inventory_image = "madblocks_drum.png",
	wield_image =  "madblocks_drum.png",
	paramtype = "light",

	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[8,9;]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})
minetest.register_node("madblocks:barrel", {
	description = "Barrel",
	drawtype = 'plantlike',
	tile_images = {"madblocks_barrel.png"},
	inventory_image = "madblocks_barrel.png",
	wield_image =  "madblocks_barrel.png",
	paramtype = "light",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[8,9;]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

minetest.register_node("madblocks:pylon", {
	description = "Pylon",
	drawtype = "glasslike",
	tile_images = {"madblocks_power_pylon.png"},
	inventory_image = minetest.inventorycube("madblocks_power_pylon.png"),
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:safetyladder", {
	description = "Ladder",
	drawtype = "signlike",
	tile_images = {"madblocks_power_polepegs.png"},
	inventory_image = "madblocks_power_polepegs.png",
	wield_image = "madblocks_power_polepegs.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {	type = "wallmounted" },
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node(":madblocks:lampling", {
	description = "Lampling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tile_images = {"madblocks_lampling.png"},
	inventory_image = "madblocks_lampling.png",
	wield_image = "madblocks_lampling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_node("madblocks:sheetmetal", {
	description = "Sheet Metal",
	tile_images = {"madblocks_sheetmetal_top.png","madblocks_sheetmetal_top.png","madblocks_sheetmetal.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:rosebush", {
	description = "Rose Bush",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = {"madblocks_rosebush.png"},
	paramtype = "light",
	groups = {snappy=3,  flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("madblocks:rubber", {
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	description = "Rubber",
	tile_images = { "madblocks_rubber_ends.png", "madblocks_rubber_ends.png", "madblocks_rubber_side.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("madblocks:bigben", {
	description = "Big Ben",
	tile_images = {"madblocks_bigben_top.png","madblocks_bigben_top.png","madblocks_bigben.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("madblocks:coffee", {
	description = "Roasted Coffee",
	tile_images = {"madblocks_coffee.png"},
	inventory_image = minetest.inventorycube("madblocks_coffee.png"),
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:fancybracket", {
	description = "Fancy Support Bracket",
	drawtype = "torchlike",
	tile_images = {"madblocks_fancybracket.png", "madblocks_fancybracket.png", "madblocks_fancybracket.png"},
	inventory_image = "madblocks_fancybracket.png",
	wield_image = "madblocks_fancybracket.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("madblocks:cinderblock_planter", {
	description = "Cinderblock Planter",
	tile_images = {"madblocks_cinderblock_planter.png","madblocks_cinderblock.png"},
	inventory_image = minetest.inventorycube("madblocks_cinderblock_planter.png","madblocks_cinderblock.png","madblocks_cinderblock.png"),
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("madblocks:awning", {
	drawtype = "raillike",
	visual_scale = 1.0,
	paramtype = "light",
	description = "Awning",
	tile_images = {"madblocks_awning.png","madblocks_awning2.png"},
	inventory_image  = "madblocks_awning.png",
	light_propagates = true,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
})


