--New FNF Mod
--look inside
--photochad

--this wacky (wip) bs was coded by vman_2002

photochadfunkin = {
	--shared
	running = false,
	
	--song
	mania = 4, --corrosponds DIRECTLY to the number of keys (4 is 4, etc.)
	
	--game settings
	downscroll = false,
	binds = {
		[4] = {{d = true, left = true}, {f = true, down = true}, {j = true, up = true}, {k = true, right = true}},
		[6] = {{s = true, z = true}, {d = true, x = true}, {f = true, c = true}, {j = true, left = true}, {k = true, down = true}, {l = true, right = true}},
		[7] = {{s = true, z = true}, {d = true, x = true}, {f = true, c = true}, {space = true}, {j = true, left = true}, {k = true, down = true}, {l = true, right = true}},
		[8] = {{a = true}, {s = true}, {d = true}, {f = true}, {j = true}, {k = true}, {l = true}, {[";"] = true}},
		[9] = {{a = true}, {s = true}, {d = true}, {f = true}, {space = true}, {j = true}, {k = true}, {l = true}, {[";"] = true}}
	},
	keyHolds = {false, false, false, false, false, false, false, false, false},
	
	--score
	score, health = 0, 1,
	sicks, good, bads, shits = 0, 0, 0, 0,
	hits, misses, accuracy = 0, 0, 100,
	
	--management
	start = function()
		if running then	return print("Tried to start FNF but it's already started!") end
		running = true
		
		photochadfunkin.score, photochadfunkin.health = 0, 100
		photochadfunkin.sicks, photochadfunkin.goods, photochadfunkin.bads, photochadfunkin.shits = 0, 0, 0, 0
		photochadfunkin.hits, photochadfunkin.misses, photochadfunkin.accuracy = 0, 0, 100
	end,
	song = function(song)
		photochadfunkin.song = assert(SMODS.load_file("lua/fnf/songs/"..song..".lua"))().song
		photochadfunkin.songPath = ((photochadfunkin.song.song):lower()):gsub("%s", "-")
		SMODS.Sound {
			key = "fnf_inst",
			path = photochadfunkin.songPath .. "-inst.ogg"
		}
		SMODS.Sound {
			key = "fnf_voices",
			path = photochadfunkin.songPath .. "-voices.ogg"
		}
		if photochadfunkin.song.keyCount then
			photochadfunkin.mania = photochadfunkin.song.keyCount
		elseif photochadfunkin.song.maniaStr then
			photochadfunkin.mania = tonumber(photochadfunkin.song.maniaStr:sub(1, -2))
		elseif photochadfunkin.song.mania then
			photochadfunkin.mania = ({4, 6, 7, 9})[photochadfunkin.song.mania + 1]
		else
			photochadfunkin.mania = 4
		end
		if not photochadfunkin.binds[photochadfunkin.mania] then
			error("Loaded chart "..song.." has mania "..tostring(photochadfunkin.mania)..", but there's no keybinds for it")
		end
		for k = 1, photochadfunkin.mania do
			photochadfunkin.keyHolds[k] = false
		end
	end,
	
	--game
	bindForKey = function(n)
		for k,v in pairs(photochadfunkin.binds[photochadfunkin.mania]) do
			--vn like visual novel lolol
			if v[n] then return k end
		end
		return nil
	end,
	keyEvents = {}
}

photochadfunkin.song("god-eater-hard")

do
	local photochadfunkin, next = photochadfunkin, next --yes this is an optimization
	local _update = love.update
	function love.update(...)
		_update(...)
		
		if next(photochadfunkin.keyEvents) ~= nil then
			for k, v in pairs(photochadfunkin.keyEvents) do
				--v[1]: When the key was pressed, relative to application start
				--v[2]: The KeyConstant that was pressed
				--v[3]: true if it was just pressed, false if it was just released
				print(v[1], v[2], v[3])
			end
			photochadfunkin.keyEvents = {}
		end
	end
end