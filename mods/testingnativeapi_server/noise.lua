--Create noise generator to use for testing

testparam = {
   offset = 0,
   scale = 1,
   spread = {x=2048, y=2048, z=2048},
   seed = 1337,
   octaves = 6,
   persist = 0.6
}

mapDim = {x=3, y=3, z=3}

p = PerlinNoiseMap(testparam, mapDim);

loc = {x=1,y=1}
loc3d = {x=1,y=1,z=1}

sliceOffset={0,0,0}
sliceSize={2,2,2}

minetest.register_chatcommand("lua_noise_get2dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_2d_map",
	func = function(self)
        local res = p:get_2d_map(loc);
        if res then
            return true, "Success, get_2d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get2dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_2d_map",
	func = function(self)
        local res = p:native_get_2d_map(loc);
        if res then
            return true, "Success, native_get_2d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get2dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_get_2d_map",
	func = function(self)
		local lua = p:get_2d_map(loc);
		local native = p:native_get_2d_map(loc);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_2d_map()"
		else
			return false, "(Fail) [Noise] get_2d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get2dmapflat", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_2d_map_flat",
	func = function(self)
        local res = p:get_2d_map_flat(loc,true);
        if res then
            return true, "Success, get_2d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("native_noise_get2dmapflat", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_2d_map_flat",
	func = function(self)
        local res = p:native_get_2d_map_flat(loc,true);
        if res then
            return true, "Success, native_get_2d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get2dmapflat", {
	description = "Asserts lua api and native api behaviors for l_noise_get_2d_map_flat",
	func = function(self)
		local lua = p:get_2d_map_flat(loc,true);
		local native = p:native_get_2d_map_flat(loc,true);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_2d_map_flat()"
		else
			return false, "(Fail) [Noise] get_2d_map_flat()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get3dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_3d_map",
	func = function(self)
        local res = p:get_3d_map(loc3d);
        if res then
            return true, "Success, get_3d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get3dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_3d_map",
	func = function(self)
        local res = p:native_get_3d_map(loc3d);
        if res then
            return true, "Success, native_get_3d_map() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get3dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_get_3d_map",
	func = function(self)
		local lua = p:get_3d_map(loc3d);
		local native = p:native_get_3d_map(loc3d);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_3d_map()"
		else
			return false, "(Fail) [Noise] get_3d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_get3dmapflat", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_3d_map_flat",
	func = function(self)
        local res = p:get_3d_map_flat(loc3d,false);
        if res then
            return true, "Success, get_3d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})


minetest.register_chatcommand("native_noise_get3dmapflat", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_3d_map_flat",
	func = function(self)
        local res = p:native_get_3d_map_flat(loc3d,false);
        if res then
            return true, "Success, native_get_3d_map_flat() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_get3dmapflat", {
	description = "Asserts lua api and native api behaviors for l_noise_get_3d_map_flat",
	func = function(self)
		local lua = p:get_3d_map_flat(loc3d,false);
		local native = p:native_get_3d_map_flat(loc3d,false);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_3d_map_flat()"
		else
			return false, "(Fail) [Noise] get_3d_map_flat()"
		end
	end
})

--NOTE: calc2dMap and calc3dMap return nothing to the lua stack

minetest.register_chatcommand("lua_noise_calc2dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_calc_2d_map",
	func = function(self)
        local res = p:calc_2d_map(loc);
        return true, "Success, calc_2d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_noise_calc2dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_calc_2d_map",
	func = function(self)
        local res = p:native_calc_2d_map(loc);
        return true, "Success, native_calc_2d_map() returned: "..dump(res)

	end
})

minetest.register_chatcommand("test_noise_calc2dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_calc_2d_map",
	func = function(self)
		local lua = p:calc_2d_map(loc);
		local native = p:native_calc_2d_map(loc);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] calc_2d_map()"
		else
			return false, "(Fail) [Noise] calc_2d_map()"
		end
	end
})


minetest.register_chatcommand("lua_noise_calc3dmap", {
	description = "Invokes lua_api > l_noise.l_lua_noise_calc_3d_map",
	func = function(self)
        local res = p:calc_3d_map(loc3d);
        return true, "Success, calc_3d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_noise_calc3dmap", {
	description = "Invokes lua_api > l_noise.l_native_noise_calc_3d_map",
	func = function(self)
        local res = p:native_calc_3d_map(loc3d);
        return true, "Success, native_calc_3d_map() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_noise_calc3dmap", {
	description = "Asserts lua api and native api behaviors for l_noise_calc_3d_map",
	func = function(self)
		local lua = p:calc_3d_map(loc3d);
		local native = p:native_calc_3d_map(loc3d);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] calc_3d_map()"
		else
			return false, "(Fail) [Noise] calc_3d_map()"
		end
	end
})

minetest.register_chatcommand("lua_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_lua_noise_get_map_slice",
	func = function(self)
        local res = p:get_map_slice(sliceOffset,sliceSize,true);
        if res then
            return true, "Success, get_map_slice() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("native_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_map_slice",
	func = function(self)
        local res = p:native_get_map_slice(sliceOffset,sliceSize,true);
        if res then
            return true, "Success, native_get_map_slice() returned: "..dump(res)
        else
            return false, "Cannot return perlin noise map" 
        end
	end
})

minetest.register_chatcommand("test_noise_getmapslice", {
	description = "Invokes lua_api > l_noise.l_native_noise_get_map_slice",
	func = function(self)
        local lua = p:get_map_slice(sliceOffset,sliceSize,true);
		local native = p:native_get_map_slice(sliceOffset,sliceSize,true);
		if dump(lua) == dump(native) then
			return true, "(Success) [Noise] get_map_slice()"
		else
			return false, "(Fail) [Noise] get_map_slice()"
		end
	end
})

--TESTS for PCGRandom Class

minetest.register_chatcommand("lua_noise_next", {
	description = "Invokes lua_api > l_noise.l_lua_noise_next",
	func = function(self)
		local PCGrand = PcgRandom(42)
        local res = PCGrand:next(25, 250)
        if res then
            return true, "Success, next() returned: "..res
        else
            return false, "Failed to return random #" 
        end
	end
})

minetest.register_chatcommand("native_noise_next", {
	description = "Invokes lua_api > l_noise.l_native_lua_noise_next",
	func = function(self)
		local PCGrand = PcgRandom(42)
        local res = PCGrand:native_next(25, 250)
        if res then
            return true, "Success, native_next() returned: "..res
        else
            return false, "Failed to return random #" 
        end
	end
})

minetest.register_chatcommand("test_noise_next", {
	description = "Invokes lua_api > l_noise.l_native_noise_next",
	func = function(self)
        local PCGrand1 = PcgRandom(42)
		local PCGrand2 = PcgRandom(42)

		local lua =  PCGrand1:next(25, 250)
		local native =  PCGrand2:native_next(25, 250)
		if lua == native then
			return true, "(Success) [Noise] next()"
		else
			return false, "(Fail) [Noise] next()"
		end
	end
})

minetest.register_chatcommand("lua_noise_randnormaldist", {
	description = "Invokes lua_api > l_noise.l_native_rand_normal_dist",
	func = function(self)
		local PCGrand = PcgRandom(42)
        local res = PCGrand:rand_normal_dist(25, 250,4)
        if res then
            return true, "Success, rand_normal_dist() returned: "..dump(res)
        else
            return false, "Failed to return random dist" 
        end
	end
})

minetest.register_chatcommand("native_noise_randnormaldist", {
	description = "Invokes lua_api > l_noise.l_native_rand_normal_dist",
	func = function(self)
		local PCGrand = PcgRandom(42)
        local res = PCGrand:native_rand_normal_dist(25, 250,4)
        if res then
            return true, "Success, native_rand_normal_dist() returned: "..dump(res)
        else
            return false, "Failed to return random dist" 
        end
	end
})

minetest.register_chatcommand("test_noise_randnormaldist", {
	description = "Invokes lua_api > l_noise.l_native_rand_normal_dist",
	func = function(self)
        local PCGrand1 = PcgRandom(42)
		local PCGrand2 = PcgRandom(42)

		local lua =  PCGrand1:rand_normal_dist(25, 250,4)
		local native =  PCGrand2:native_rand_normal_dist(25, 250,4)
		if lua == native then
			return true, "(Success) [Noise] rand_normal_dist()"
		else
			return false, "(Fail) [Noise] rand_normal_dist()"
		end
	end
})

--TESTS for SecureRandom Class

minetest.register_chatcommand("lua_noise_nextbytes", {
	description = "Invokes lua_api > l_noise.l_lua_next_bytes",
	func = function(self)
		SECrand = SecureRandom(42)
        local res = SECrand:next_bytes(4)
        if res then
            return true, "Success, next_bytes() returned: "..dump(res)
        else
            return false, "Failed to return next bytes" 
        end
	end
})

minetest.register_chatcommand("native_noise_nextbytes", {
	description = "Invokes lua_api > l_noise.l_native_next_bytes",
	func = function(self)
		SECrand = SecureRandom(42)
        local res = SECrand:native_next_bytes(4)
        if res then
            return true, "Success, native_next_bytes() returned: "..dump(res)
        else
            return false, "Failed to return next bytes" 
        end
	end
})
--Unlike random numbers, there is no seed for bytes, so they will likely never be the same value
minetest.register_chatcommand("test_noise_nextbytes", {
	description = "Asserts lua api and native api behaviors for l_noise_next_bytes",
	func = function(self)
		SECrand1 = SecureRandom(42)
		SECrand2 = SecureRandom(42)
        local lua = SECrand1:next_bytes(25,250)
		local native = SECrand2:next_bytes(25,250)
        if lua ~= native then
			return true, "(Success) [Noise] next_bytes()"
		else
			return false, "(Fail) [Noise] next_bytes()"
		end
	end
})

--TESTS for pseudoRandom Class

minetest.register_chatcommand("lua_noise_nextPS", {
	description = "Invokes lua_api > l_noise.l_lua_next (PS)",
	func = function(self)
		local PSrand = PseudoRandom(42)
        local res = PSrand:next(25,250)
        if res then
            return true, "Success, next_PS() returned: "..dump(res)
        else
            return false, "Failed to return next pseudoRandom num" 
        end
	end
})

minetest.register_chatcommand("native_noise_nextPS", {
	description = "Invokes lua_api > l_noise.l_lua_next (PS)",
	func = function(self)
		local PSrand = PseudoRandom(42)
        local res = PSrand:native_nextPS(25,250)
        if res then
            return true, "Success, next_PS() returned: "..dump(res)
        else
            return false, "Failed to return next pseudoRandom num" 
        end
	end
})

minetest.register_chatcommand("test_noise_nextPS", {
	description = "Asserts lua api and native api behaviors for l_noise_nextPS",
	func = function(self)
		local PSrand = PseudoRandom(42)
		local PSrand2 = PseudoRandom(42)
        local lua = PSrand:next(25,250)
		local native = PSrand2:native_nextPS(25,250)
		if lua == native then
			return true, "(Success) [Noise] nextPS()"
		else
			return false, "(Fail) [Noise] nextPS()"
		end
	end
})


--command to test entire class
minetest.register_chatcommand("test_noise", {
	description = "testing all noise methods",
	func = function()

		local methods = {
			"get2dmap",
			"get2dmapflat",
			"get3dmap",
			"get3dmapflat",
			"calc2dmap",
			"calc3dmap",
			"getmapslice",
			"next",
			"randnormaldist",
			"nextPS",
			"nextbytes"
		}

		return native_tests.test_class("noise", methods), 
		"Settings tests completed. See server_dump.txt for details."
	end
})