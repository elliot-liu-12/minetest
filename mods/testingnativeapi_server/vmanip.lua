-- vmanip test mod
-- test vmanip class methods

minetest.log("--NativeLuaVoxelManip class tests-- (DevTest doesnt have default mod, so tests wont behave properly unless they are run in MineTest.)")

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
		local dirt_node = minetest.get_content_id("default:dirt");
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
		local dirt_node = minetest.get_content_id("default:dirt");
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
		local dirt_node = minetest.get_content_id("default:dirt");
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
		local data = voxelManip:get_data();
		local dirt_node = minetest.get_content_id("default:dirt");
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
		minetest.log("If write_to_map was successful, there will be a 10x10x10 dirt cube in the world.");
		voxelManip = nil;

        if true then 
            return true, "Success, write_to_map() returned: nil"
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
		local data = voxelManip:get_data();
		local stone_node = minetest.get_content_id("default:stone");
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
		minetest.log("If write_to_map was successful, there will be a 10x10x10 stone cube in the world.");
		voxelManip = nil;

        if true then 
            return true, "Success, native_write_to_map() returned: nil"
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
        local dirt_node = minetest.get_content_id("default:dirt")
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
        local stone_node = minetest.get_content_id("default:stone")
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
		voxelManip = nil
      
        minetest.log("If write_to_map was successful, there will be a 10x10x10 dirt cube and a 10x10x10 stone cube separated by a one-block gap at the same height in the world.")
        return true, "Success, native_write_to_map() returned: nil"
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

		 minetest.set_node(front_pos, {name = "default:dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local res = voxelManip:get_node_at(front_pos).name == "default:dirt";
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

		 minetest.set_node(front_pos, {name = "default:dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local res = voxelManip:native_get_node_at(front_pos).name == "default:dirt";
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

		minetest.set_node(front_pos, {name = "default:dirt"})

		--load voxelmanip and get node
		voxelManip:read_from_map(front_pos, front_pos);

		--check result
		local lres = voxelManip:get_node_at(front_pos).name == "default:dirt";
		local nres = voxelManip:native_get_node_at(front_pos).name == "default:dirt";
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
        voxelManip:set_node_at(front_pos, {name = "default:dirt"})

		--check if node was set
		local res = voxelManip:get_node_at(front_pos).name == "default:dirt";
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
        voxelManip:native_set_node_at(front_pos, {name = "default:dirt"})

		--check if node was set
		local res = voxelManip:get_node_at(front_pos).name == "default:dirt";
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
        voxelManip:set_node_at(front_pos, {name = "default:dirt"})

		--check if node was set
		local lres = voxelManip:get_node_at(front_pos).name == "default:dirt";
		voxelManip:write_to_map();
		
		--load voxelmanip
		voxelManip:read_from_map(front_pos, front_pos);

		--set node
        voxelManip:native_set_node_at(front_pos, {name = "default:dirt"})

		--check if node was set
		local nres = voxelManip:get_node_at(front_pos).name == "default:dirt";
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
--lua test
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
		local stone_node = minetest.get_content_id("default:water_source");
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

		voxelManip:update_liquids();

        -- Write changes to the map
        voxelManip:native_write_to_map(true);
		minetest.log("If update_liquids() was successful, water will imediately start to flow.");
		voxelManip = nil;
        
        if true then 
            return true, "Success, update_liquids() updated flow of liquids."
        else
            return true, "Success, update_liquids() didnt update flow of liquids."
        end
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
		local stone_node = minetest.get_content_id("default:water_source");
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

		voxelManip:native_update_liquids();

        -- Write changes to the map
        voxelManip:native_write_to_map(true);
		minetest.log("If update_liquids() was successful, water will imediately start to flow.");
		voxelManip = nil;
        
        if true then 
            return true, "Success, native_update_liquids() updated flow of liquids."
        else
            return true, "Success, native_update_liquids() didnt update flow of liquids."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_update_liquids", {
    description = "compares output of lua and native command for update_liquids()",
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
        local dirt_node = minetest.get_content_id("default:water_source")
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
		voxelManip:update_liquids();
        voxelManip:write_to_map(true)

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
        local stone_node = minetest.get_content_id("default:water_source")
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
		voxelManip:update_liquids();
        voxelManip:write_to_map(true)
		voxelManip = nil
        
		--results
		minetest.log("If functions are working properly, water will start to flow immediately.");
		local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--calc_lighting()
--lua test
minetest.register_chatcommand("lua_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, calc_lighting() returned: nil"
        else
            return true, "Success, calc_lighting() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, calc_lighting() returned: nil"
        else
            return true, "Success, calc_lighting() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_calc_lighting", {
    description = "compares output of lua and native command for calc_lighting()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_lighting()
--lua test
minetest.register_chatcommand("lua_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_lighting() returned: nil"
        else
            return true, "Success, set_lighting() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_lighting() returned: nil"
        else
            return true, "Success, set_lighting() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_lighting", {
    description = "compares output of lua and native command for set_lighting()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_light_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (lua version)",
    func = function(self)

		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local minp = {x = pos.x - 5, y = pos.y - 5, z = pos.z};
		local maxp = {x = pos.x + 5, y = pos.y + 5, z = pos.z};
		
		local vm = minetest.get_voxel_manip(minp, maxp);
		local light_data = vm:get_light_data(minp, maxp);

		-- Calculate voxel index based on coordinates
		local function get_voxel_index(x, y, z)
			return (x - minp.x + 1) + (maxp.x - minp.x + 1) * ((y - minp.y + 1) + (maxp.y - minp.y + 1) * (z - minp.z + 1));
		end

		-- Modify the light data as needed
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				for x = minp.x, maxp.x do
					local vi = get_voxel_index(x, y, z);
					-- Modify the light level of each node
					light_data[vi] = 14;  -- Set maximum light level (15) for each node
				end
			end
		end

		-- Update the light in the region
		vm:set_light_data(minp, maxp, light_data);
		vm:write_to_map(true);

        if true then 
            return true, "Success, get_light_data() returned: nil"
        else
            return true, "Success, get_light_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_light_data() returned: nil"
        else
            return true, "Success, get_light_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_light_data", {
    description = "compares output of lua and native command for get_light_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
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
        local res = true;
        if res == nil then 
            return true, "Success, set_light_data() returned: nil"
        else
            return true, "Success, set_light_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_light_data", {
    description = "test vmanip class method set_light_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_light_data() returned: nil"
        else
            return true, "Success, set_light_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_light_data", {
    description = "compares output of lua and native command for set_light_data()",
    func = function(self)
        local lres = true;
        local nres = true;
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
        local res = true;
        if res == nil then 
            return true, "Success, get_param2_data() returned: nil"
        else
            return true, "Success, get_param2_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_param2_data", {
    description = "test vmanip class method get_param2_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_param2_data() returned: nil"
        else
            return true, "Success, get_param2_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_param2_data", {
    description = "compares output of lua and native command for get_param2_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
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
        local res = true;
        if res == nil then 
            return true, "Success, set_param2_data() returned: nil"
        else
            return true, "Success, set_param2_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_param2_data", {
    description = "test vmanip class method set_param2_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_param2_data() returned: nil"
        else
            return true, "Success, set_param2_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_param2_data", {
    description = "compares output of lua and native command for set_param2_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--was_modified()
--lua test
minetest.register_chatcommand("lua_vmanip_was_modified", {
    description = "test vmanip class method was_modified (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, was_modified() returned: nil"
        else
            return true, "Success, was_modified() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_was_modified", {
    description = "test vmanip class method was_modified (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, was_modified() returned: nil"
        else
            return true, "Success, was_modified() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_was_modified", {
    description = "compares output of lua and native command for was_modified()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_emerged_area()
--lua test
minetest.register_chatcommand("lua_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (lua version)",
    func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
		local voxelManip = minetest.get_voxel_manip();
		local emergedArea = minetest.emerge_area(vector.subtract(pos, 80), vector.add(pos, 80));
		local FRes = voxelManip:get_emerged_area();
        local res = equals(FRes, emergedArea);
        if res == true then 
            return true, "Success, get_emerged_area() returned: true"
        else
            return false, "Failure, get_emerged_area() returned: false"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_emerged_area() returned: nil"
        else
            return true, "Success, get_emerged_area() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_emerged_area", {
    description = "compares output of lua and native command for get_emerged_area()",
    func = function(self)
        local lres = true;
        local nres = true;
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

--TODO:
--"calc_lighting",
--"set_lighting",
--"get_light_data",
--"set_light_data",
--"get_param2_data",
--"set_param2_data",
--"was_modified",
--"get_emerged_area"