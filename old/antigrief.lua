function table.set(t) -- set of list
  local u = { }
  for _, v in ipairs(t) do u[v] = true end
  return u
end

function table.find(f, l) -- find element v of l satisfying f(v)
  for _, v in ipairs(l) do
    if f(v) then
      return v
    end
  end
  return nil
end

local function set_param(param,v)
    local output = nil
    local output_file = nil

    if param == 'shield' then 
		output_file = GODTOOLS.SHIELD 
	  	if v == true then
			output = '1'	
    	elseif v == false then
			output = '0'
		else return
		end
   		SHIELD = v 
    elseif param == 'prot1' and v.x and v.y and v.z then
		output_file = GODTOOLS.PROT1
    	output = v.x..','..v.y..','..v.z
    	PROT1 = v
    elseif param == 'prot2'  and v.x and v.y and v.z then
		output_file = GODTOOLS.PROT2
    	output = v.x..','..v.y..','..v.z
    	PROT2 = v
    else return
    end

    local f = io.open(output_file, "w")
    f:write(output)
    io.close(f)
end
compare = function(p1,p2)
	result = {}
	if p1 > p2 then
		result.high = p1
		result.low = p2
		result.diff = p1 - p2
	elseif p2 > p1 then
		result.high = p2
		result.low = p1
		result.diff = p2 - p1
	else
		result.high = p2
		result.low = p1
		result.diff = 0
	end
	if result.diff < 0 then 
		result.diff = -result.diff
		result.mul = -1
	else result.mul = 1 end
	return result
end

GODTOOLS = {}

-- ***********************************************************************************
--		ANTIGRIEF / PROTECTION AREA	**************************************************
-- ***********************************************************************************
--ENABLE_PROTECTION = true		-- uncomment if using godtools w/o madblocks
if ENABLE_PROTECTION == true then
	GODTOOLS.SHIELD = minetest.get_worldpath()..'/godtools.shield'
	GODTOOLS.PROT1 = minetest.get_worldpath()..'/godtools.prot1'
	GODTOOLS.PROT2 = minetest.get_worldpath()..'/godtools.prot2'

	SHIELD = false
	BACKUP_BUCKET = {}
	PROT1 = {}
	PROT2 = {}

	local paramshield = io.open(GODTOOLS.SHIELD, "r")
	local paramprot1 = io.open(GODTOOLS.PROT1, "r")
	local paramprot2 = io.open(GODTOOLS.PROT2, "r")

	if paramshield ~= nil then
		value = paramshield:read("*n")
		if value == 1 then
			SHIELD = true
			io.close(paramshield)
		elseif value == 0 then
			SHIELD = false
			io.close(paramshield)
		else
			set_param('shield',false)	
		end
	else
		print('no shield file, setting default off')
		set_param('shield',false)
	end

	if paramprot1 ~= nil then
		local value = paramprot1:read()
		local p = {}
		p.x, p.y, p.z = string.match(value, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then
			PROT1.x = tonumber(p.x)
			PROT1.y = tonumber(p.y)
			PROT1.z = tonumber(p.z)
			io.close(paramprot1)
		else
			set_param('prot1',{x=-500,y=-500,z=-500})
		end
	else
		print('no prot1 file, setting default -500,-500,-500')
		set_param('prot1',{x=-500,y=-500,z=-500})
	end

	if paramprot2 ~= nil then
		local value = paramprot2:read()
		local p = {}
		p.x, p.y, p.z = string.match(value, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then
			PROT2.x = tonumber(p.x)
			PROT2.y = tonumber(p.y)
			PROT2.z = tonumber(p.z)
			io.close(paramprot2)
		else
			set_param('prot2',{x=500,y=500,z=500})
		end
	else
		print('no prot2 file, setting default 500,500,500')
		set_param('prot2',{x=500,y=500,z=500})
	end

	minetest.register_chatcommand("shield", {
		params = "<onoff>",
		description = "griefing countermeasures",
		privs = {server=true},
		func = function(name, param)
			if param == 'on' then 
				set_param('shield',true)
	--			SHIELD = true
				BACKUP_BUCKET = bucket.liquids
				bucket.liquids = {}
				minetest.chat_send_player(name, "shield up.")
			elseif param == 'off' then 
				set_param('shield',false)
	--			SHIELD = false
				bucket.liquids = BACKUP_BUCKET
				minetest.chat_send_player(name, "shield down.")
			else minetest.chat_send_player(name, "invalid paramter, try 'on' or 'off'.")
			end
		end,
	})
	minetest.register_chatcommand("prot1", {
		params = "<X>,<Y>,<Z>",
		description = "first corner",
		privs = {server=true},
		func = function(name, param)
			local p = {}
			p.x, p.y, p.z = string.match(param, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
			if p.x and p.y and p.z then
				set_param('prot1',{x= tonumber(p.x),y=tonumber(p.y),z=tonumber(p.z)})
				minetest.chat_send_player(name, "Fill1 set to ("..p.x..", "..p.y..", "..p.z..")")
				return
			else 
				local target = minetest.env:get_player_by_name(name)
				if target then
					set_param('prot1',target:getpos())
					minetest.chat_send_player(name, "Fill1 set to ("..PROT1.x..", "..PROT1.y..", "..PROT1.z..")")
					return
				end
			end
		end,
	})
	minetest.register_chatcommand("prot2", {
		params = "<X>,<Y>,<Z>",
		description = "opposite corner",
		privs = {server=true},
		func = function(name, param)
			local p = {}
			p.x, p.y, p.z = string.match(param, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
			if p.x and p.y and p.z then
				set_param('prot2',{x= tonumber(p.x),y=tonumber(p.y),z=tonumber(p.z)})
				minetest.chat_send_player(name, "Fill2 set to ("..p.x..", "..p.y..", "..p.z..")")
				return
			else 
				local target = minetest.env:get_player_by_name(name)
				if target then
					set_param('prot2',target:getpos())
					minetest.chat_send_player(name, "Fill2 set to ("..PROT2.x..", "..PROT2.y..", "..PROT2.z..")")
					return
				end
			end
		end,
	})
	minetest.register_on_placenode(function(p, node)
		if SHIELD == true then
			if node.name == "default:water_source" or node.name == "default:lava_source" then
				minetest.env:remove_node(p)
			elseif PROT1 and PROT2 then
				local xd = compare(PROT1.x,PROT2.x)
				local yd = compare(PROT1.y,PROT2.y)
				local zd = compare(PROT1.z,PROT2.z)
				if p.x >= xd.low and p.x <= xd.high and p.y >= yd.low and p.y <= yd.high and p.z >= zd.low and p.z <= zd.high then
					minetest.env:remove_node(p)
				end
			end
		end
	end)

	minetest.register_on_dignode(function(p, node)
		if SHIELD == true and PROT1 and PROT2 then
			local xd = compare(PROT1.x,PROT2.x)
			local yd = compare(PROT1.y,PROT2.y)
			local zd = compare(PROT1.z,PROT2.z)
			print(p.x..' '..p.y..' '..p.z)
			print(xd.low..' '..xd.high..' '..yd.low..' '..yd.high..' '..zd.low..' '..zd.high)
			if p.x >= xd.low and p.x <= xd.high and p.y >= yd.low and p.y <= yd.high and p.z >= zd.low and p.z <= zd.high then
				minetest.env:add_node(p,{type="node",name=node.name})
		 		print('VICTORY')
			end
		
		end

	end)
end





   
