local function normalize(nodeid,nodename)
   if nodename == nil then
      nodename = nodeid[1]:upper()..nodeid:sub(2)
   end
   return nodename
end

local function moduleSpecific(module)
   local function fence(nodeid,nodename)
      nodename = normalize(nodeid,nodename)
      minetest.register_node(
         module..":"..nodeid.."_fence", {
            description = nodename.." Fence",
            drawtype = "fencelike",
            tile_images = {module.."_"..nodeid..".png"},
            inventory_image = module.."_"..nodeid.."_fence.png",
            wield_image = module.."_"..nodeid.."_fence.png",
            paramtype = "light",
            is_ground_content = true,
            selection_box = {
               type = "fixed",
               fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
            },
            groups = {cracky=3},
            sounds = default.node_sound_wood_defaults(),
         })
   end

   local function metal(nodeid, nodename,hasFence)
      nodename = normalize(nodeid,nodename)
      minetest.register_node(
         module..":"..nodeid, {
            description = nodename,
            tile_images = {module.."_"..nodeid..".png"},
            inventory_image = minetest.inventorycube(module.."_"..nodeid..".png"),
            is_ground_content = true,
            groups = {cracky=3},
            sounds = default.node_sound_wood_defaults(),
         })
      if hasFence == true then
         fence(nodeid,nodename)
      end
   end
   local function glow(nodeid,nodename,drawtype)
      nodename = normalize(nodeid,nodename)
      if drawtype == nil then 
         drawtype = 'glasslike'
         inv_image = minetest.inventorycube(module.."_"..nodeid..".png")
      else 
         inv_image = module.."_"..nodeid..".png" 
      end
      minetest.register_node(
         module..":"..nodeid, 
         {
            description = nodename,
            drawtype = drawtype,
            tile_images = {module.."_"..nodeid..".png"},
            inventory_image = inv_image,
            light_propagates = true,
            paramtype = "light",
            sunlight_propagates = true,
            light_source = 15	,
            is_ground_content = true,
            groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
            sounds = default.node_sound_glass_defaults(),
         })
   end
   local function brick (nodeid, nodename)
      nodename = normalize(nodeid,nodename)
      minetest.register_node(
         module..":"..nodeid, 
         {
            description = nodename,
            tile_images = {module.."_"..nodeid..'.png'},
            inventory_image = minetest.inventorycube(module.."_"..nodeid..'.png'),
            is_ground_content = true,
            groups = {cracky=3},
            sounds = default.node_sound_stone_defaults(),
         })
   end
   local function wood (nodeid, nodename,hasFence)
      nodename = normalize(nodeid,nodename)
      minetest.register_node(
         module..":"..nodeid, 
         {
            description = nodename,
            tile_images = {module.."_"..nodeid..".png"},
            inventory_image = minetest.inventorycube(module.."_"..nodeid..".png"),
            is_ground_content = true,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
            sounds = default.node_sound_wood_defaults(),
         })
      if hasFence == true then
         fence(nodeid,nodename)
      end
   end
   local function sign (nodeid, arg)
      if arg == nil then arg = {} end
      local light = arg['light'] or 0
      local infix = arg['infix'] or "signs_"
      minetest.register_node(
         module..":"..infix..nodeid, 
         {
            description = arg['description'] or "Sign",
            drawtype = "signlike",
            tile_images = {module.."_"..infix..nodeid..".png"},
            inventory_image = module.."_"..infix..nodeid..".png",
            wield_image = module.."_"..infix..nodeid..".png",
            paramtype = "light",
            paramtype2 = "wallmounted",
            is_ground_content = true,
            walkable = false,
            climbable = false,
            selection_box = {
               type = "wallmounted",
            },
            light_source = light	,
            light_propagates = true,
            sunlight_propagates = true,
            on_punch = arg['on_punch'],
            after_dig_node = arg['after_dig_node'],
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
            legacy_wallmounted = true,
            sounds = default.node_sound_stone_defaults(),
         })
   end
   local function plant (nodeid, nodename, type, option, arg)

      if option == nil then option = false end
      if arg == nil then arg = {} end
      
      local params ={ description = nodename, 
                      drawtype = "plantlike", 
                      tile_images = {module.."_"..nodeid..'.png'}, 
                      inventory_image = module.."_"..nodeid..'.png',
                      wield_image = module.."_"..nodeid..'.png', 
                      paramtype = "light",
                      on_punch = arg['on_punch'],
                      after_dig_node = arg['after_dig_node']
                   }
      
      if type == 'veg' then
         params.groups = {snappy=2,dig_immediate=3,flammable=2}
         params.sounds = default.node_sound_leaves_defaults()
         if option == false then params.walkable = false end
      elseif type == 'met' then			-- metallic
         params.groups = {cracky=3}
         params.sounds = default.node_sound_stone_defaults()
      elseif type == 'cri' then			-- craft items
         params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
         params.sounds = default.node_sound_wood_defaults()
         if option == false then params.walkable = false end
      elseif type == 'eat' then			-- edible
         params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
         params.sounds = default.node_sound_wood_defaults()
         params.walkable = false
         params.on_use = minetest.item_eat(option)
      end
      minetest.register_node(module..":"..nodeid, params)
   end
   
   return {fence=fence,metal=metal,glow=glow,brick=brick,wood=wood,sign=sign,plant=plant}
end

return moduleSpecific