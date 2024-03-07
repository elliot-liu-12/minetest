-- vmanip test mod
-- test vmanip class methods

minetest.log("--NativeLuaVoxelManip class tests--")

--observations:
--was_modified() can only become true for a mapgen VoxelManip. Since this can only be obtained when the map is generated, the test result of the chat command will always be false.
--calc_lighting() is only to be used in a mapgen voxelManip, so it cant be tested here the same way the other methods are being tested.
--set_lighting() is only to be used in a mapgen voxelManip, so it cant be tested here the same way the other methods are being tested.

--compare tables
-- https://stackoverflow.com/questions/20325332/how-to-check-if-two-tablesobjects-have-the-same-value-in-lua
function equals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

--register custom dirt
minetest.register_node(":dirt", {
    description = "Dirt",
    tiles = {"default_dirt.png"},
    groups = {crumbly = 3, soil = 1}
})

--register custom stone
minetest.register_node(":stone", {
    description = "Stone",
    tiles = {"default_stone.png"},
    groups = {cracky = 3}
})

--register custom water
local WATER_ALPHA = "^[opacity:" .. 160
local WATER_VISC = 1
minetest.register_node("testingnativeapi_server:water_source", {
	description = "Water Source".."\n"..
		"Swimmable, spreading, renewable liquid".."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = {"default_water.png"..WATER_ALPHA},
	special_tiles = {
		{name = "default_water.png"..WATER_ALPHA, backface_culling = false},
		{name = "default_water.png"..WATER_ALPHA, backface_culling = true},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "testingnativeapi_server:water_flowing",
	liquid_alternative_source = "testingnativeapi_server:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	post_effect_color_shaded = true,
	groups = {water = 3, liquid = 3},
})

minetest.register_node("testingnativeapi_server:water_flowing", {
	description = "Flowing Water".."\n"..
		"Swimmable, spreading, renewable liquid".."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"default_water_flowing.png"},
	special_tiles = {
		{name = "default_water_flowing.png"..WATER_ALPHA,
			backface_culling = false},
		{name = "default_water_flowing.png"..WATER_ALPHA,
			backface_culling = false},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "testingnativeapi_server:water_flowing",
	liquid_alternative_source = "testingnativeapi_server:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	post_effect_color_shaded = true,
	groups = {water = 3, liquid = 3},
})

--read_from_map()
--lua test
minetest.register_chatcommand("lua_vmanip_read_from_map", {
    description = "test vmanip class method read_from_map (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--get area around player
		local tempPos = pos;
		tempPos.x = pos.x + 20;
		tempPos.y = pos.y + 20;
		tempPos.z = pos.z + 20;

		--read area into vmanip, returns min and max
		local res1, res2 = voxelManip:read_from_map(pos, tempPos);

		--get min and max from vmanip
		local res4, res5 = voxelManip:get_emerged_area();

		--check result
		local finalRes = (equals(res1, res4)) and (equals(res2, res5));
        if finalRes then 
            return true, "Success, read_from_map() loaded the chunck."
        else
            return false, "Failure, read_from_map() didnt correctly load the chunk."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_read_from_map", {
    description = "test vmanip class method read_from_map (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--get area around player
		local tempPos = pos;
		tempPos.x = pos.x + 20;
		tempPos.y = pos.y + 20;
		tempPos.z = pos.z + 20;

		--read area into vmanip, returns min and max
		local res1, res2 = voxelManip:native_read_from_map(pos, tempPos);

		--get min and max from vmanip
		local res4, res5 = voxelManip:get_emerged_area();

		--check result
		local finalRes = (equals(res1, res4)) and (equals(res2, res5));
        if finalRes then 
            return true, "Success, read_from_map() loaded the chunck."
        else
            return false, "Failure, read_from_map() didnt correctly load the chunk."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_read_from_map", {
    description = "compares output of lua and native command for read_from_map()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--get area around player
		local tempPos = pos;
		tempPos.x = pos.x + 20;
		tempPos.y = pos.y + 20;
		tempPos.z = pos.z + 20;

		--read area into vmanip
		local lres1, lres2 = voxelManip:read_from_map(pos, tempPos);
		local nres1, nres2 = voxelManip:native_read_from_map(pos, tempPos);
        if (equals(lres1, nres1) and equals(lres2, nres2)) then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_data", {
    description = "test vmanip class method get_data (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--read into Vmanip
		local lres1, lres2 = voxelManip:read_from_map(pos, pos);

		--get data loaded into vmanip
		local data = voxelManip:get_data();

		--Check if data is not empty
        local res = next(data);
        if res ~= nil then 
            return true, "Success, get_data() returned: data in table"
        else
            return false, "Failure, get_data() returned: empty table"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_data", {
    description = "test vmanip class method get_data (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--read into Vmanip
		local lres1, lres2 = voxelManip:read_from_map(pos, pos);

		--get data loaded into vmanip
		local data = voxelManip:native_get_data();

		--Check if data is not empty
        local res = next(data);
        if res ~= nil then 
            return true, "Success, get_data() returned: data in table"
        else
            return false, "Failure, get_data() returned: empty table"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_data", {
    description = "compares output of lua and native command for get_data()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--read into Vmanip
		local lres1, lres2 = voxelManip:read_from_map(pos, pos);

		--get data loaded into vmanip
		local ldata = voxelManip:get_data();
		local ndata = voxelManip:native_get_data();

		--Check if data is not empty
        local lres = next(ldata);
        local nres = next(ndata);
        if ((lres == nres) and (lres ~= nil)) then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_data()
-- lua test
minetest.register_chatcommand("lua_vmanip_set_data", {
    description = "test vmanip class method set_data (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--create positions
		local pos1 = {
			x = pos.x - 5,
			y = pos.y - 5,
			z = pos.z - 5
		}
		local pos2 = {
			x = pos.x + 4,
			y = pos.y + 4,
			z = pos.z + 4
		}

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node
				end
			end
		end

		-- Set data to the data
        voxelManip:set_data(data);

        --check if data was changed
		local res = equals(voxelManip:get_data(), data);
        
        if res then 
            return true, "Success, set_data() changed data."
        else
            return false, "Failure, set_data() did not change data."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_data", {
    description = "test vmanip class method set_data (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--create positions
		local pos1 = {
			x = pos.x - 5,
			y = pos.y - 5,
			z = pos.z - 5
		}
		local pos2 = {
			x = pos.x + 4,
			y = pos.y + 4,
			z = pos.z + 4
		}

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node
				end
			end
		end

		-- Set data to the data
        voxelManip:native_set_data(data);

        --check if data was changed
		local res = equals(voxelManip:get_data(), data);
        
        if res then 
            return true, "Success, native_set_data() changed data."
        else
            return false, "Failure, native_set_data() did not change data."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_data", {
    description = "compares output of lua and native command for set_data()",
    func = function(self)
			--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();
		local voxelManip2 = minetest.get_voxel_manip();

		--create positions
		local pos1 = {
			x = pos.x - 5,
			y = pos.y - 5,
			z = pos.z - 5
		}
		local pos2 = {
			x = pos.x + 4,
			y = pos.y + 4,
			z = pos.z + 4
		}

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local Nres1, Nres2 = voxelManip2:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}
		local area2 = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_data();
		local data2 = voxelManip2:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node
				end
			end
		end
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area2:index(x, y, z)
					data[vi] = dirt_node
				end
			end
		end

		-- Set data to the data
        voxelManip:set_data(data);
		voxelManip2:native_set_data(data2);

        --check if data was changed
		local lres = equals(voxelManip:get_data(), data);
        local nres = equals(voxelManip2:get_data(), data2);
     
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--write_to_map()
--lua test
minetest.register_chatcommand("lua_vmanip_write_to_map", {
    description = "test vmanip class method write_to_map (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local oldData = voxelManip:get_data(); --original data.
		local data = voxelManip:get_data(); --will be changed into dirt cube data.
		local dirt_node = minetest.get_content_id("dirt");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node
				end
			end
		end

		-- Set data to the data
        voxelManip:set_data(data);

        -- Write changes to the map
        voxelManip:write_to_map(true);
		data = voxelManip:get_data();
		voxelManip = nil;

		--Check results
		local res = equals(oldData, data);

        if not res then 
            return true, "Success, write_to_map() spawned the dirt cube in the map."
        else
            return false, "Failure, write_to_map() didnt spawn the dirt cube in the map."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_write_to_map", {
    description = "test vmanip class method write_to_map (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local oldData = voxelManip:get_data(); --original data.
		local data = voxelManip:get_data(); --will be changed into dirt cube data.
		local stone_node = minetest.get_content_id("dirt");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = stone_node
				end
			end
		end

		-- Set data to the data
        voxelManip:set_data(data);

        -- Write changes to the map
        voxelManip:native_write_to_map(true);
		data = voxelManip:get_data();
		voxelManip = nil;

		--Check results
		local res = equals(oldData, data);

        if not res then 
            return true, "Success, native_write_to_map() spawned the dirt cube in the map."
        else
            return false, "Failure, native_write_to_map() didnt spawn the dirt cube in the map."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_write_to_map", {
    description = "compares output of lua and native command for write_to_map()",
    func = function(self)
        --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local pos = player:get_pos()
        local dir = player:get_look_dir()
        local voxelManip = minetest.get_voxel_manip()

		--DIRT CUBE (LUA)
        -- Calculate positions
        local pos_front_dirt = vector.round(vector.add(pos, vector.multiply(dir, 10)))
        local pos1_dirt = vector.subtract(pos_front_dirt, 4)
        local pos2_dirt = vector.add(pos_front_dirt, 5)

        --Read data to vmanip
        local res1_dirt, res2_dirt = voxelManip:read_from_map(pos1_dirt, pos2_dirt)
        local area_dirt = VoxelArea:new{
            MinEdge = res1_dirt,
            MaxEdge = res2_dirt
        }

        --add dirt cube
        local data_dirt = voxelManip:get_data()
		local old_data_dirt = voxelManip:get_data()
        local dirt_node = minetest.get_content_id("dirt")
        for z = pos1_dirt.z, pos2_dirt.z do
            for y = pos1_dirt.y, pos2_dirt.y do
                for x = pos1_dirt.x, pos2_dirt.x do
                    local vi = area_dirt:index(x, y, z)
                    data_dirt[vi] = dirt_node
                end
            end
        end

        --Spawn cube
        voxelManip:set_data(data_dirt)
        voxelManip:write_to_map(true)
		data_dirt = voxelManip:get_data()

		--STONE CUBE (NATIVE)
        --Calculate positions
        local pos1_stone = vector.add(pos2_dirt, 1) 
        local pos2_stone = vector.add(pos1_stone, 9) 
        pos1_stone.y = pos1_dirt.y
        pos2_stone.y = pos2_dirt.y

        --Read to vmanip
        local res1_stone, res2_stone = voxelManip:read_from_map(pos1_stone, pos2_stone)
        local area_stone = VoxelArea:new{
            MinEdge = res1_stone,
            MaxEdge = res2_stone
        }

        --add stone cube
        local data_stone = voxelManip:get_data()
		local old_data_stone = voxelManip:get_data()
        local stone_node = minetest.get_content_id("stone")
        for z = pos1_stone.z, pos2_stone.z do
            for y = pos1_stone.y, pos2_stone.y do
                for x = pos1_stone.x, pos2_stone.x do
                    local vi = area_stone:index(x, y, z)
                    data_stone[vi] = stone_node
                end
            end
        end

        --spawn cube
        voxelManip:set_data(data_stone)
        voxelManip:write_to_map(true)
		data_stone = voxelManip:get_data()
		voxelManip = nil
      
		--Check results
		local lres = (equals(old_data_dirt, data_dirt));
		local nres = (equals(old_data_stone, data_stone));
        if not lres and not nres then 
            return true, "Success, function output matches - check console for more details."
        else
            return false, "Failure, function output does not match - check console for more details."
        end
    end
})

--get_node_at()
--lua test
minetest.register_chatcommand("lua_vmanip_get_node_at", {
    description = "test vmanip class method get_node_at (lua version)",
    func = function(name)
        --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		 minetest.set_node(front_pos, {name = "dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local res = voxelManip:get_node_at(front_pos).name == "dirt";
		voxelManip = nil;
        if res then
            return true, "Success, get_node_at returned dirt block data."
        else
            return false, "Failure, get_node_at did not return dirt block data."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_node_at", {
    description = "test vmanip class method get_node_at (native version)",
    func = function(self)
        --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		 minetest.set_node(front_pos, {name = "dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local res = voxelManip:native_get_node_at(front_pos).name == "dirt";
		voxelManip = nil;
        if res then
            return true, "Success, get_node_at returned dirt block data."
        else
            return false, "Failure, get_node_at did not return dirt block data."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_node_at", {
    description = "compares output of lua and native command for get_node_at()",
    func = function(self)
                --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		minetest.set_node(front_pos, {name = "dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local lres = voxelManip:get_node_at(front_pos).name == "dirt";
		local nres = voxelManip:native_get_node_at(front_pos).name == "dirt";
		voxelManip = nil;
        
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_node_at()
--lua test
minetest.register_chatcommand("lua_vmanip_set_node_at", {
    description = "test vmanip class method set_node_at (lua version)",
    func = function(self)
	    --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		--load voxelmanip
		voxelManip:read_from_map(front_pos, front_pos);

		--set node
        voxelManip:set_node_at(front_pos, {name = "dirt"})

		--check if node was set
		local res = voxelManip:get_node_at(front_pos).name == "dirt";
		voxelManip:write_to_map();
		voxelManip = nil;
        
        if res then 
            return true, "Success, set_node_at() set dirt node."
        else
            return false, "Failure, set_node_at() didnt set dirt node."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_node_at", {
    description = "test vmanip class method set_node_at (native version)",
    func = function(self)
	    --Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		--load voxelmanip
		voxelManip:read_from_map(front_pos, front_pos);

		--set node
        voxelManip:native_set_node_at(front_pos, {name = "dirt"})

		--check if node was set
		local res = voxelManip:get_node_at(front_pos).name == "dirt";
		voxelManip:write_to_map();
		voxelManip = nil;
        
        if res then 
            return true, "Success, native_set_node_at() set dirt node."
        else
            return false, "Failure, native_set_node_at() didnt set dirt node."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_node_at", {
    description = "compares output of lua and native command for set_node_at()",
    func = function(self)
		--Get vmanip
        local player = minetest.get_player_by_name("singleplayer")
        local voxelManip = minetest.get_voxel_manip()

		--calculate position
		local pos = player:get_pos()
        local dir = player:get_look_dir()
		local front_pos = {
			x = pos.x + dir.x,
			y = pos.y + dir.y,
			z = pos.z + dir.z
		}

		--load voxelmanip
		voxelManip:read_from_map(front_pos, front_pos);

		--set node
        voxelManip:set_node_at(front_pos, {name = "dirt"})

		--check if node was set
		local lres = voxelManip:get_node_at(front_pos).name == "dirt";
		voxelManip:write_to_map();
		
		--load voxelmanip
		voxelManip:read_from_map(front_pos, front_pos);

		--set node
        voxelManip:native_set_node_at(front_pos, {name = "dirt"})

		--check if node was set
		local nres = voxelManip:get_node_at(front_pos).name == "dirt";
		voxelManip:write_to_map();
        voxelManip = nil;
    
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--update_map()
--lua test
minetest.register_chatcommand("lua_vmanip_update_map", {
    description = "test vmanip class method update_map (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--call update map
		voxelManip:update_map(); --does nothing, kept for compatibility.
        if true then 
            return true, "Success, update_map() returned: nil"
        else
            return false, "Failure, update_map() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_update_map", {
    description = "test vmanip class method update_map (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--call update map
		voxelManip:native_update_map(); --does nothing, kept for compatibility.
        if true then 
            return true, "Success, native_update_map() returned: nil"
        else
            return false, "Failure, native_update_map() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_update_map", {
    description = "compares output of lua and native command for update_map()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();

		--call update map
		voxelManip:update_map(); --does nothing, kept for compatibility.
		voxelManip:native_update_map(); --does nothing, kept for compatibility.
        if true then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--update_liquids()
--lua table
minetest.register_chatcommand("lua_vmanip_update_liquids", {
    description = "test vmanip class method update_liquids (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_data();
		local water_node = minetest.get_content_id("testingnativeapi_server:water_source");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = water_node
				end
			end
		end

		--set data to the data
        voxelManip:set_data(data);
		voxelManip:update_liquids();

        --write changes to the map
        voxelManip:native_write_to_map(true);

		--check results
		minetest.after(2, function() --wait for water to have time to flow
            local res = false
            for z = pos1.z - 1, pos2.z + 1 do --check around the cube for flow
                for y = pos1.y - 1, pos2.y + 1 do
                    for x = pos1.x - 1, pos2.x + 1 do
                        if minetest.get_node({x=x, y=y, z=z}).name == "testingnativeapi_server:water_flowing" then
                            res = true
                        end
                    end
                end
            end
            voxelManip = nil
            if res then --log correct message
                minetest.chat_send_player("singleplayer", "Success, update_liquids() updated flow of liquids.") 
            else
                minetest.chat_send_player("singleplayer", "Failure, update_liquids() didn't update flow of liquids.")
            end
        end)
		return true; --return for test result (actual result depends on printed statement from above).
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_update_liquids", {
    description = "test vmanip class method update_liquids (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_data();
		local water_node = minetest.get_content_id("testingnativeapi_server:water_source");
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = water_node
				end
			end
		end

		--set data to the data
        voxelManip:set_data(data);
		voxelManip:native_update_liquids();

        --write changes to the map
        voxelManip:native_write_to_map(true);

		--check results
		minetest.after(2, function() --wait for water to have time to flow
            local res = false
            for z = pos1.z - 1, pos2.z + 1 do --check around the cube for flow
                for y = pos1.y - 1, pos2.y + 1 do
                    for x = pos1.x - 1, pos2.x + 1 do
                        if minetest.get_node({x=x, y=y, z=z}).name == "testingnativeapi_server:water_flowing" then
                            res = true
                        end
                    end
                end
            end
            voxelManip = nil
            if res then --log correct message
                minetest.chat_send_player("singleplayer", "Success, native_update_liquids() updated flow of liquids.") 
            else
                minetest.chat_send_player("singleplayer", "Failure, native_update_liquids() didn't update flow of liquids.")
            end
        end)
		return true; --return for test result (actual result depends on printed statement from above).
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_update_liquids", {
    description = "compares output of lua and native command for update_liquids()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local lpos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local lpos1 = vector.subtract(lpos_front, 4);
        local lpos2 = vector.add(lpos_front, 5);

		--read into Vmanip
		local lres1, lres2 = voxelManip:read_from_map(lpos1, lpos2);
		local area = VoxelArea:new{
			MinEdge = lres1,
			MaxEdge = lres2
		}

		--edit data in vmanip
		local ldata = voxelManip:get_data();
		local water_node = minetest.get_content_id("testingnativeapi_server:water_source");
		for z = lpos1.z, lpos2.z do
			for y = lpos1.y, lpos2.y do
				for x = lpos1.x, lpos2.x do
					local vi = area:index(x, y, z)
					ldata[vi] = water_node
				end
			end
		end

		--set data to the data
        voxelManip:set_data(ldata);
		voxelManip:update_liquids();

        --write changes to the map
        voxelManip:native_write_to_map(true);

		--water cube (native)	
		--create positions
		local npos1 = vector.add(lpos2, 1) 
        local npos2 = vector.add(npos1, 9) 
        npos1.y = lpos1.y
        npos2.y = lpos2.y

        --Read to vmanip
        local nres1, nres2 = voxelManip:read_from_map(npos1, npos2)
        local area_stone = VoxelArea:new{
            MinEdge = nres1,
            MaxEdge = nres2
        }

        --add stone cube
        local data_native_water = voxelManip:get_data()
        for z = npos1.z, npos2.z do
            for y = npos1.y, npos2.y do
                for x = npos1.x, npos2.x do
                    local vi = area_stone:index(x, y, z)
                    data_native_water[vi] = water_node
                end
            end
        end

        --spawn cube
        voxelManip:set_data(data_native_water)
		voxelManip:native_update_liquids();
        voxelManip:write_to_map(true)

		--check results
		local lres, nres = false;
		minetest.after(2, function() --wait for water to have time to flow
            local res = false
            for z = lpos1.z - 1, lpos2.z + 1 do --check around the cube for flow
                for y = lpos1.y - 1, lpos2.y + 1 do
                    for x = lpos1.x - 1, lpos2.x + 1 do
                        if minetest.get_node({x=x, y=y, z=z}).name == "testingnativeapi_server:water_flowing" then
                            lres = true
                        end
                    end
                end
            end
			for z = npos1.z - 1, npos2.z + 1 do --check around the cube for flow
                for y = npos1.y - 1, npos2.y + 1 do
                    for x = npos1.x - 1, npos2.x + 1 do
                        if minetest.get_node({x=x, y=y, z=z}).name == "testingnativeapi_server:water_flowing" then
                            nres = true
                        end
                    end
                end
            end
            voxelManip = nil
            if nres == lres then --log correct message
                minetest.chat_send_player("singleplayer", "Success, function output matches - check console for more details.") 
            else
                minetest.chat_send_player("singleplayer", "Failure, function output does not match - check console for more details.")
            end
        end)
		return true; --return for test result (actual result depends on printed statement from above).
    end
})

--calc_lighting()
--lua test
local enableLuaCalc = false;
local enableNativeCalc = false;
minetest.register_on_generated(function(minp, maxp, blockseed) --only way to use calc_lighting()
		if enableLuaCalc or enableNativeCalc then
			--get voxel manip
			local player = minetest.get_player_by_name("singleplayer");
			local pos = player:get_pos();
			local dir = player:get_look_dir();
			local voxelManip =minetest.get_mapgen_object("voxelmanip")
		
			--create positions
			local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
			local pos1 = vector.subtract(pos_front, 4);
			local pos2 = vector.add(pos_front, 5);

			--read area into Vmanip
			local res1, res2 = voxelManip:read_from_map(pos1, pos2);
			local data = voxelManip:get_light_data();
			local area = VoxelArea:new{
				MinEdge = res1,
				MaxEdge = res2
			}

			--edit light data in vmanip
			for z = pos1.z, pos2.z do
				for y = pos1.y, pos2.y do
					for x = pos1.x, pos2.x do
						local vi = area:index(x, y, z);
						data[vi] = 0x0;
						--minetest.log(data[vi]);
					end
				end
			end

			--update light
			voxelManip:set_lighting(data);
			if enableLuaCalc then
				voxelManip:calc_lighting();
			end
			if enableNativeCalc then
				voxelManip:native_calc_lighting();
			end

			--check result
			data = voxelManip:get_light_data();
			local res = false;
			for z = pos1.z, pos2.z do
				for y = pos1.y, pos2.y do
					for x = pos1.x, pos2.x do
						local vi = area:index(x, y, z);
						--minetest.log(data[vi]);
						if (data[vi] == 0x0) then
							res = true;
						end
					end
				end
			end
			voxelManip = nil;
			--minetest.chat_send_all(tostring(res))
			--minetest.chat_send_all(tostring(enableLua))
			--minetest.chat_send_all(tostring(enableNative))
			if (enableLuaCalc and enableNativeCalc) and res then
				minetest.chat_send_all("Success, function output matches.")
			elseif (enableLuaCalc and enableNativeCalc) and not res then
				minetest.chat_send_all("Failure, function output doesnt match.")
			else
				if res and enableLuaCalc then
					minetest.chat_send_all("Success, calc_lighting() updated light data.")
				elseif not res and enableLuaCalc then
					minetest.chat_send_all("Failure, calc_lighting() didnt update light data.")
				end
				if res and enableNativeCalc then
					minetest.chat_send_all("Success, native_calc_lighting() updated light data.")
				elseif not res and enableNativeCalc then
					minetest.chat_send_all("Failure, native_calc_lighting() didnt update light data.")
				end
			end
		end
end)

minetest.register_chatcommand("lua_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (lua version)",
    func = function(self)
		enableLua = true;
		return true;
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (native version)",
    func = function(self)
        enableNative = true;
		return true;
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_calc_lighting", {
    description = "compares output of lua and native command for calc_lighting()",
    func = function(self)
        enableLua = true;
		enableNative = true;
		return true;
    end
})

--stop testing
minetest.register_chatcommand("stop_vmanip_calc_lighting", {
    description = "stops test for on generated calc_lighting().",
    func = function(self)
        enableLua = false;
		enableNative = false;
		return true;
    end
})

--set_lighting()
local enableLuaSet = false;
local enableNativeSet = false;
minetest.register_on_generated(function(minp, maxp, blockseed) --only way to use set_lighting()
		if enableLuaSet or enableNativeSet then
			--get voxel manip
			local player = minetest.get_player_by_name("singleplayer");
			local pos = player:get_pos();
			local dir = player:get_look_dir();
			local voxelManip =minetest.get_mapgen_object("voxelmanip")
		
			--create positions
			local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
			local pos1 = vector.subtract(pos_front, 4);
			local pos2 = vector.add(pos_front, 5);

			--read area into Vmanip
			local res1, res2 = voxelManip:read_from_map(pos1, pos2);
			local data = voxelManip:get_light_data();
			local area = VoxelArea:new{
				MinEdge = res1,
				MaxEdge = res2
			}

			--edit light data in vmanip
			if enableLuaSet then
				voxelManip:set_lighting({day = 0, night = 0}, pos1, pos2);
			end
			if enableNativeSet then
				voxelManip:native_set_lighting({day = 0, night = 0}, pos1, pos2);
			end
			voxelManip:calc_lighting();
			voxelManip:write_to_map();

			--check result
			data = voxelManip:get_light_data();
			local res = false;
			for z = pos1.z, pos2.z do
				for y = pos1.y, pos2.y do
					for x = pos1.x, pos2.x do
						local vi = area:index(x, y, z);
						--minetest.log(data[vi]);
						if (data[vi] == 0x0) then
							res = true;
						end
					end
				end
			end
			voxelManip = nil;
			--minetest.chat_send_all(tostring(res))
			--minetest.chat_send_all(tostring(enableLuaSet))
			--minetest.chat_send_all(tostring(enableNativeSet))
			if (enableLuaSet and enableNativeSet) and res then
				minetest.chat_send_all("Success, function output matches.")
			elseif (enableLuaSet and enableNativeSet) and not res then
				minetest.chat_send_all("Failure, function output doesnt match.")
			else
				if res and enableLuaSet then
					minetest.chat_send_all("Success, set_lighting() updated light data.")
				elseif not res and enableLuaSet then
					minetest.chat_send_all("Failure, set_lighting() didnt update light data.")
				end
				if res and enableNativeSet then
					minetest.chat_send_all("Success, native_set_lighting() updated light data.")
				elseif not res and enableNativeSet then
					minetest.chat_send_all("Failure, native_set_lighting() didnt update light data.")
				end
			end
		end
end)
--lua test
minetest.register_chatcommand("lua_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (lua version).",
    func = function(self)
		enableLuaSet = true;
		return true;
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (native version).",
    func = function(self)
        enableNativeSet = true;
		return true;
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_lighting", {
    description = "compares output of lua and native command for set_lighting().",
    func = function(self)
        enableLuaSet = true;
		enableNativeSet = true;
		return true;
    end
})

--stop test
minetest.register_chatcommand("stop_vmanip_set_lighting", {
    description = "stops test for on_generated set_lighting().",
    func = function(self)
        enableLuaSet = false;
		enableNativeSet = false;
		return true;
    end
})

--get_light_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--get data in vmanip
		local data = voxelManip:get_light_data();
		voxelManip = nil;

		--check results
        local res = next(data) ~= nil;

        if res then 
            return true, "Success, get_light_data() returned light data array."
        else
            return false, "Failure, get_light_data() didnt return light data array."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--get data in vmanip
		local data = voxelManip:native_get_light_data();
		voxelManip = nil;

		--check results
        local res = next(data) ~= nil;

        if res then 
            return true, "Success, native_get_light_data() returned light data array."
        else
            return false, "Failure, native_get_light_data() didnt return light data array."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_light_data", {
    description = "compares output of lua and native command for get_light_data()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--get light data in vmanip
		local ldata = voxelManip:get_light_data();
		local ndata = voxelManip:native_get_light_data();
		voxelManip = nil;

		--check results
		local equalData = equals(ldata, ndata);
        local lres = next(ldata) ~= nil;
		local nres = next(ndata) ~= nil;
        local finalRes = (lres == nres) and equalData;
        if finalRes then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_light_data()
--lua test
minetest.register_chatcommand("lua_vmanip_set_light_data", {
    description = "test vmanip class method set_light_data (lua version)",
    func = function(self)
        --get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--spawn dirt cube and make its light 15
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		local light_data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node;
					light_data[vi] = 15;
				end
			end
		end
		voxelManip:set_data(data);
		voxelManip:set_light_data(light_data);
		voxelManip:write_to_map(true);
		
		--Check results
        local res = false;
		data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					if(data[vi] == 15) then
						res = true;
					end						
				end
			end
		end
		voxelManip = nil;
        if res then 
            return true, "Success, set_light_data() changed light data to 15."
        else
            return false, "Failure, set_light_data() didnt change light data to 15."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_light_data", {
    description = "test vmanip class method set_light_data (native version)",
    func = function(self)
        --get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--spawn dirt cube and make its light 15
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		local light_data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node;
					light_data[vi] = 15;
				end
			end
		end
		voxelManip:set_data(data);
		voxelManip:native_set_light_data(light_data);
		voxelManip:write_to_map(true);
		
		--Check results
        local res = false;
		data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					if(data[vi] == 15) then
						res = true;
					end						
				end
			end
		end
		voxelManip = nil;
        if res then 
            return true, "Success, set_light_data() changed light data to 15."
        else
            return false, "Failure, set_light_data() didnt change light data to 15."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_light_data", {
    description = "compares output of lua and native command for set_light_data()",
    func = function(self)
	    --get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--spawn dirt cube and make its light 15
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("dirt");
		local light_data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node;
					light_data[vi] = 15;
				end
			end
		end
		voxelManip:set_data(data);
		voxelManip:set_light_data(light_data);
		voxelManip:write_to_map(true);
		
		--Check results
        local lres = false;
		data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					if(data[vi] == 15) then
						lres = true;
					end						
				end
			end
		end
		       
		--create positions
		pos_front = vector.round(vector.add(pos, vector.multiply(dir, 20)));
        pos1 = vector.subtract(pos_front, 4);
        pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		res1, res2 = voxelManip:read_from_map(pos1, pos2);
		area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--spawn dirt cube and make its light 15
		data = voxelManip:get_data();
		dirt_node = minetest.get_content_id("dirt");
		light_data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					data[vi] = dirt_node;
					light_data[vi] = 15;
				end
			end
		end
		voxelManip:set_data(data);
		voxelManip:set_light_data(light_data);
		voxelManip:write_to_map(true);
		
		--Check results
        local nres = false;
		data = voxelManip:get_light_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
					if(data[vi] == 15) then
						nres = true;
					end						
				end
			end
		end
		voxelManip = nil;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_param2_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_param2_data", {
    description = "test vmanip class method get_param2_data (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_param2_data(); --original data.
		voxelManip = nil;

		--check results
        local res = next(data) ~= nil;
        if res then 
            return true, "Success, get_param2_data() returned data array."
        else
            return false, "Failure, get_param2_data() didnt return data array."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_param2_data", {
    description = "test vmanip class method get_param2_data (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:native_get_param2_data(); --original data.
		voxelManip = nil;

		--check results
        local res = next(data) ~= nil;
        if res then 
            return true, "Success, native_get_param2_data() returned data array."
        else
            return false, "Failure, native_get_param2_data() didnt return data array."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_param2_data", {
    description = "compares output of lua and native command for get_param2_data()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local ldata = voxelManip:get_param2_data(); --original data.
		local ndata = voxelManip:native_get_param2_data(); --original data.
		voxelManip = nil;

		--check results
        local lres = next(ldata) ~= nil;
		local nres = next(ndata) ~= nil;
        local finalRes = (lres == nres) and equals(ldata, ndata);
        if finalRes then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_param2_data()
--lua test
minetest.register_chatcommand("lua_vmanip_set_param2_data", {
    description = "test vmanip class method set_param2_data (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_param2_data(); --original data.
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						data[vi] = 1
				end
			end
		end

		voxelManip:set_param2_data(data)
		voxelManip:write_to_map(true);
		
		--Check results
        local res = true;
		data = voxelManip:get_param2_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						if(data[vi] ~= 1) then
							res = false;
						end						
				end
			end
		end
		voxelManip = nil;
        if res then 
            return true, "Success, set_param2_data() changed param2 data."
        else
            return false, "Failure, set_param2_data() didnt change param2 data."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_param2_data", {
    description = "test vmanip class method set_param2_data (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip
		local data = voxelManip:get_param2_data(); --original data.
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						data[vi] = 1
				end
			end
		end

		voxelManip:native_set_param2_data(data)
		voxelManip:write_to_map(true);
		
		--Check results
        local res = true;
		data = voxelManip:get_param2_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						if(data[vi] ~= 1) then
							res = false;
						end						
				end
			end
		end
		voxelManip = nil;
        if res then 
            return true, "Success, native_set_param2_data() changed param2 data."
        else
            return false, "Failure, native_set_param2_data() didnt change param2 data."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_param2_data", {
    description = "compares output of lua and native command for set_param2_data()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);
		local area = VoxelArea:new{
			MinEdge = res1,
			MaxEdge = res2
		}

		--edit data in vmanip (LUA)
		local data = voxelManip:get_param2_data(); --original data.
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						data[vi] = 1
				end
			end
		end

		voxelManip:set_param2_data(data)
		voxelManip:write_to_map(true);
		
		--Check results
        local lres = true;
		data = voxelManip:get_param2_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						if(data[vi] ~= 1) then
							res = false;
						end						
				end
			end
		end

		--edit data in vmanip (NATIVE)
		local data = voxelManip:get_param2_data(); --original data.
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						data[vi] = 2
				end
			end
		end

		voxelManip:set_param2_data(data)
		voxelManip:write_to_map(true);
		
		--Check results
        local nres = true;
		data = voxelManip:get_param2_data();
		for z = pos1.z, pos2.z do
			for y = pos1.y, pos2.y do
				for x = pos1.x, pos2.x do
					local vi = area:index(x, y, z)
						if(data[vi] ~= 2) then
							res = false;
						end						
				end
			end
		end
		voxelManip = nil;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--was_modified()
local enableLuaModified = false;
local enableNativeModified = false;
local modify = true; --change this to test different bahavior from was_modified()
minetest.register_on_generated(function(minp, maxp, blockseed) --only way to use was_modified()
		if enableLuaModified or enableNativeModified then
			--get voxel manip
			local player = minetest.get_player_by_name("singleplayer");
			local pos = player:get_pos();
			local voxelManip = minetest.get_mapgen_object("voxelmanip")
		
			--create positions
			local pos_under = {x = pos.x, y = pos.y - 1, z = pos.z}

			--read area into Vmanip
			local res1, res2 = voxelManip:read_from_map(pos_under, pos_under);
			local data = voxelManip:get_data();

			--edit light data in vmanip
			if modify then
				minetest.set_node({x=pos_under.x,y=pos_under.y,z=pos_under.z}, {name = "dirt"})
			end

			--update light
			voxelManip:set_data(data);
			local lres = false;
			local nres = false;
			if enableLuaModified then
				lres = voxelManip:was_modified();
			end
			if enableNativeModified then
				nres = voxelManip:native_was_modified();
			end
			
			--check result
			voxelManip = nil;
			--minetest.chat_send_all(tostring(lres))
			--minetest.chat_send_all(tostring(nres))
			--minetest.chat_send_all(tostring(enableLuaModified))
			--minetest.chat_send_all(tostring(enableNativeModified))
			if (enableLuaModified and enableNativeModified) and lres == nres then
				minetest.chat_send_all("Success, function output matches.")
			elseif (enableLuaModified and enableNativeModified) and lres ~= nres then
				minetest.chat_send_all("Failure, function output doesnt match.")
			else
				if lres and enableLuaModified then
					minetest.chat_send_all("Success, was_modified() returned true.")
				elseif not lres and enableLuaModified then
					minetest.chat_send_all("Failure, was_modified() returned false.")
				end
				if nres and enableNativeModified then
					minetest.chat_send_all("Success, native_was_modified() returned true.")
				elseif not nres and enableNativeModified then
					minetest.chat_send_all("Failure, native_was_modified() returned false.")
				end
			end
		end
end)

--lua test
minetest.register_chatcommand("lua_vmanip_was_modified", {
    description = "test vmanip class method was_modified (lua version)",
	func = function(self)
		enableLuaModified = true;
		return modify;
	end
})


--native test 
minetest.register_chatcommand("native_vmanip_was_modified", {
    description = "test vmanip class method was_modified (native version)",
    func = function(self)
		enableNativeModified = true;
		return modify;
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_was_modified", {
    description = "compares output of lua and native command for was_modified()",
    func = function(self)
		enableLuaModified = true;
		enableNativeModified = true;
		return modify;
    end
})

--stop test
minetest.register_chatcommand("stop_vmanip_was_modified", {
    description = "stops testing of on_generated was_modified()",
    func = function(self)
		enableLuaModified = false;
		enableNativeModified = false;
		return modify;
    end
})

--get_emerged_area()
--lua test
minetest.register_chatcommand("lua_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (lua version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);

        -- Get area
		local trueMin, trueMax = voxelManip:get_emerged_area();
        voxelManip = nil;

		--check results
		local res = (equals(trueMin, res1)) and (equals(trueMax, res2));
        if res then 
            return true, "Success, get_emerged_area() returned valid positions."
        else
            return false, "Failure, get_emerged_area() returned invalid positions."
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (native version)",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);

        -- Get area
		local trueMin, trueMax = voxelManip:native_get_emerged_area();
        voxelManip = nil;

		--check results
		local res = (equals(trueMin, res1)) and (equals(trueMax, res2));
        if res then 
            return true, "Success, native_get_emerged_area() returned valid positions."
        else
            return false, "Failure, native_get_emerged_area() returned invalid positions."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_emerged_area", {
    description = "compares output of lua and native command for get_emerged_area()",
    func = function(self)
		--get voxel manip
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local dir = player:get_look_dir();
		local voxelManip = minetest.get_voxel_manip();
		
		--create positions
		local pos_front = vector.round(vector.add(pos, vector.multiply(dir, 10)));
        local pos1 = vector.subtract(pos_front, 4);
        local pos2 = vector.add(pos_front, 5);

		--read into Vmanip
		local res1, res2 = voxelManip:read_from_map(pos1, pos2);

        -- Get area
		local ltrueMin, ltrueMax = voxelManip:get_emerged_area();
		local ntrueMin, ntrueMax = voxelManip:native_get_emerged_area();
        voxelManip = nil;

		--check results
		local lres = (equals(ltrueMin, res1)) and (equals(ltrueMax, res2));
		local nres = (equals(ntrueMin, res1)) and (equals(ntrueMax, res2));
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

minetest.register_chatcommand("test_vmanip", {
    description = "testing all vmanip methods",
    func = function()

        local methods = {
            "read_from_map",
            "get_data",
            "set_data",
            "write_to_map",
            "get_node_at",
            "set_node_at",
			"update_map",
			"update_liquids",
			"calc_lighting",
			"set_lighting",
			"get_light_data",
			"set_light_data",
			"get_param2_data",
			"set_param2_data",
			"was_modified",
			"get_emerged_area"
        }

        return native_tests.test_class("vmanip", methods),
        "Vmanip tests completed. See server_dump.txt for details."
    end
})
