local like = minetest.require("madblocks","like")("madblocks")

-- ***********************************************************************************
--		SOUND NODES							**************************************************
-- ***********************************************************************************

local function moduleSpecific(module)
   local SOUNDS = {}
   function register(nodeid, nodename,drawtype)
      SOUNDS[nodeid] = {}
      SOUNDS[nodeid].sounds = {}
      local function on_punch(pos,node)
         local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
         if sound == nil then 
            local wanted_sound = {name=nodeid, gain=1.5}
            SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = {	handle = minetest.sound_play(wanted_sound, {pos=pos, loop=true}),	name = wanted_sound.name, }
            
         else 
            minetest.sound_stop(sound.handle)
            SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
         end
         
      end
      local function after_dig_node(pos,node)
         local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
         if sound ~= nil then
            minetest.sound_stop(sound.handle)
            SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
            nodeupdate(pos)
         end
      end      
	if drawtype == 'signlike' then
           like.sign(nodeid,{
                        description=nodename,
			on_punch = on_punch,
			after_dig_node = after_dig_node,
                     })
	elseif drawtype == nil or drawtype == '' then 
           like.plant(nodeid,nodename,"met",true,{
                         on_punch = on_punch,
                         after_dig_node = after_dig_node
                      })
	end
        
     end
   return register
end

return moduleSpecific