--runs every client class; output sent to console
minetest.register_chatcommand("test_client_classes", {
	description = "test all client classes",
	func = function()

		--fill this with all the class names to be tested
		local client_classes = {
			"camera",
      "client",
			"minimap",
			"item",
			"modchannels",
			"localplayer"
		}

		--test each class
		local total = 0
		local hits = 0
		for k,v in pairs(client_classes) do
			local class = minetest.registered_chatcommands["test_"..v]
			if class then
				local res = class.func()
				if res then
					hits = hits + 1
				end
			else
				native_tests.write("MISSING: test_"..v.."\n\n")
			end
			total = total + 1
		end

		--write total result to console
		native_tests.write("***CLIENT TESTS COMPLETED: "..hits.." PASSED, "..total-hits.." FAILED***\n\n")

		return true, "Client tests completed. See console for details."
	end
})