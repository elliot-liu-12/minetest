
particle = {
pos = {x = 0, y = 40, z = 0},
velocity = {x = 1, y = 1, z = 1},
acceleration = {x = 1, y = 1, z = 1},
expirationtime = 1,
size = 1,
collisiondetection = true,
texture = "default_wood.png",
playername = "singleplayer",
}

particlespawner = {
amount = 60,
time = 10,
minpos = {x = 0, y = 40, z = 0},
maxpos = {x = 0, y = 42, z = 0},
minvel = {x = 1, y = 1, z = 1},
maxvel = {x = 1, y = 1, z = 1},
minacc = {x = 1, y = 1, z = 1},
maxacc = {x = 1, y = 1, z = 1},
minexptime = 60,
maxexptime = 70,
minsize = 1,
maxsize = 4,
collisiondetection = true,
texture = "default_wood.png",
playername = "singleplayer",
}

count = 0

minetest.register_chatcommand("lua_particles_addparticle", { 
	description = "Invokes lua_api > l_particles.l_add_particle",
	func = function(self)
		local res = minetest.add_particle(particle)
		return true, "Success, add_particle() was called."
	end
})

minetest.register_chatcommand("native_particles_addparticle", {
	description = "Invokes lua_api > l_particles.l_native_add_particle > native_particles.native_add_particle",
	func = function(self)
		local res = minetest.native_add_particle(particle)
		return true, "Success, native_add_particle() was called."
	end
})

minetest.register_chatcommand("test_particles_addparticle", {
	description = "Asserts lua api and native api behaviors for l_particles.add_particle",
	func = function(self)
		local lua = minetest.add_particle(particle)
		local native = minetest.native_add_particle(particle)
		if (lua == native)
		then
			return true, "Success, lua and native api behaviors match."
		else
			return false, "Fail, lua and native api behaviors do not match."
		end
	end
})

minetest.register_chatcommand("lua_particles_addparticlespawner", {
	description = "Invokes lua_api > l_particles.l_add_particlespawner",
	func = function(self)
		spawner_id = minetest.add_particlespawner(particlespawner)
		print(spawner_id)
		if (spawner_id == -1) 
		then 
			return false, "Fail, add_particlespawner() was not called."
		else
			count = count + 1
			return true, "Success, add_particlespawner() was called."
		end
	end
})

minetest.register_chatcommand("native_particles_addparticlespawner", {
	description = "Invokes lua_api > l_particles.l_native_add_particlespawner > native_particles.native_add_particlespawner",
	func = function(self)
		spawner_id = minetest.native_add_particlespawner(particlespawner)
		print(spawner_id)
		if (spawner_id == -1) 
		then 
			return false, "Fail, native_add_particlespawner() was not called."
		else
			count = count + 1
			return true, "Success, native_add_particlespawner() was called."
		end
	end
})

minetest.register_chatcommand("test_particles_addparticlespawner", {
	description = "Asserts lua api and native api behaviors for l_particles.add_particlespawner",
	func = function(self)
		local lua = minetest.add_particlespawner(particlespawner)
		local native = minetest.native_add_particlespawner(particlespawner)
		if (native ~= null and lua ~= null) 
		then 
			return true, "Success."
		else
			return false, "Fail."
		end
	end
})

minetest.register_chatcommand("lua_particles_delparticlespawner", {
	description = "Invokes lua_api > l_particles.l_delete_particlespawner",
	func = function(self)
		if (spawner_id == -1 or count <= 0)  
		then
			return false, "There is no particlespawner to delete!"
		else
			print(spawner_id)
			minetest.delete_particlespawner(spawner_id)
			if (count >= 0) 
			then 
				spawner_id = spawner_id - 1
				count = count - 1
			end
			return true, "Success, delete_particlespawner() deleted the particlespawner."
		end
	end
})

minetest.register_chatcommand("native_particles_delparticlespawner", {
	description = "Invokes lua_api > l_particles.l_delete_particlespawner",
	func = function(self)
		if (spawner_id == -1 or count <= 0)  
		then
			return false, "There is no particlespawner to delete!"
		else
			print(minetest.native_delete_particlespawner(spawner_id))
			if (count >= 0) 
			then 
				spawner_id = spawner_id - 1
				count = count - 1
			end
			return true, "Success, native_delete_particlespawner() deleted the particlespawner."
		end
	end
})

minetest.register_chatcommand("test_particles_delparticlespawner", {
	description = "Invokes lua_api > l_particles.l_delete_particlespawner",
	func = function(self)
		if (lua == native)
		then 
			return true, "Success, lua and native api behaviors match."
		else
			return false, "Fail, lua and native api behaviors do not match."
		end
	end
})

--command to test entire class
minetest.register_chatcommand("test_particles", {
	description = "testing all particles methods",
	func = function()

		local methods = {
			"addparticle",
			"addparticlespawner",
			"delparticlespawner"
		}

		return native_tests.test_class("particles", methods), 
		"Particles tests completed. See server_dump.txt for details."
	end
})
