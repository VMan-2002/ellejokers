--New FNF Mod
--look inside
--photochad

--this wacky (wip) bs was coded by vman_2002

photochadfunkin = {
	--shared
	running, audioStarted = false, false,
	
	--song
	mania = 4, --corrosponds DIRECTLY to the number of keys (4 is 4, etc.)
	unspawnNoteIndex = false,
	startTime = 0,
	
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
	start = function(self)
		if running then	return print("Tried to start FNF but it's already started!") end
		self.keyEvents = {}
		running = true
		self.score, self.health = 0, 1
		self.sicks, self.goods, self.bads, self.shits = 0, 0, 0, 0
		self.hits, self.misses, self.accuracy = 0, 0, 100
		for k = 1, self.mania do
			self.keyHolds[k] = false
		end
		--Load shit
		self.unspawnNoteIndex = 1
		self.unspawnNotes, self.notes, self.camChanges = {}, {}, {}
		self.camPlayer = self.song.notes[1].mustHitSection
		
		--notes
		local noteData
		local mustHitSection = self.camPlayer
		for k,v in pairs(self.song.notes) do
			if v.mustHitSection ~= mustHitSection then
				self.camChanges[#self.camChanges + 1] = k
				mustHitSection = v.mustHitSection
			end
			for k2,v2 in pairs(v.sectionNotes) do
				self.unspawnNotes[#self.unspawnNotes + 1] = {
					v2[1] * 0.001, --Time (seconds)
					(v2[2] % self.mania) + 1, --Lane (starting from 1)
					(v2[2] >= self.mania) ~= mustHitSection, --True if note belongs to player
					v2[3] and (v2[3] * 0.001) or 0 --Sustain length (seconds)
				}
			end
		end
		table.sort(self.unspawnNotes, function(a, b)
			return a[1] < b[1]
		end)
		print("loaded "..tostring(#self.unspawnNotes).." notes")
		
		self:resize(love.graphics.getDimensions())
		
		self.startTime = love.timer.getTime() + 3
	end,
	song = function(self, song)
		self.song = assert(SMODS.load_file("lua/fnf/songs/"..song..".lua"))().song
		self.songPath = ((self.song.song):lower()):gsub("%s", "-")
		SMODS.Sound {
			key = "fnf_inst",
			path = self.songPath .. "-inst.ogg"
		}
		SMODS.Sound {
			key = "fnf_voices",
			path = self.songPath .. "-voices.ogg"
		}
		--Support multiple types of mania definition even tho only 1 chart format is (intentionally) supported
		if self.song.keyCount then
			self.mania = self.song.keyCount
		elseif self.song.maniaStr then
			self.mania = tonumber(self.song.maniaStr:sub(1, -2))
		elseif self.song.mania then
			self.mania = ({4, 6, 7, 9})[self.song.mania + 1]
		else
			self.mania = 4
		end
		if not self.binds[self.mania] then
			error("Loaded chart "..song.." has mania "..tostring(self.mania)..", but there's no keybinds for it")
		end
	end,
	
	--game
	bindForKey = function(self, n)
		for k,v in pairs(self.binds[self.mania]) do
			--vn like visual novel lolol
			if v[n] then return k end
		end
		return nil
	end,
	keyEvents = {}
}

for k, v in pairs({
	fnf_miss1 = "missnote1",
	fnf_miss2 = "missnote2",
	fnf_miss3 = "missnote3",
	fnf_die = "fnf_loss_sfx",
	fnf_intro3 = "intro3",
	fnf_intro2 = "intro2",
	fnf_intro1 = "intro1",
	fnf_intro0 = "introGo"
}) do
	SMODS.Sound {
		key = k,
		path = v .. ".ogg"
	}
end

for i, v in ipairs({"fnf_game"}) do
	assert(SMODS.load_file("lua/fnf/"..v..".lua"))()
end

photochadfunkin:song("god-eater-hard")