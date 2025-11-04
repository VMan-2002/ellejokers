--New FNF Mod
--look inside
--photochad

--this wacky (wip) bs was coded by vman_2002

SMODS.Sound {
	key = "stream_fnf_inst",
	path = "carpet.ogg"
}
SMODS.Sound {
	key = "stream_fnf_voices",
	path = "carpet.ogg"
}
SMODS.Sound {
	key = "music_fnf_menu",
	path = "phantomMenu.ogg",
	pitch = 1,
	select_music_track = function(self) return (G.OVERLAY_MENU and G.OVERLAY_MENU.definition.imstupidandfunkybitch) and 2 end
}
--[[SMODS.Sound {
	key = "music_fnf_menu_scary",
	path = "phantomMenuScary.ogg",
	pitch = 1,
	select_music_track = function(self) return (G.OVERLAY_MENU and G.OVERLAY_MENU.definition.imstupidandfunkybitch) and 3 end
}]]
SMODS.Sound {
	key = "music_fnf_silent",
	path = "music_silent.ogg",
	select_music_track = function(self) return photochadfunkin.running and math.huge end
}
local replaceSound = function(key, path, mod)
	assert(key and path and mod, "replaceSound called with bad args")
	local snd = SMODS.Sounds[key]
	snd.full_path = SMODS.Mods[mod].path .. "assets/sounds/" .. path
	--print("snd full path", snd.full_path)
	G.SOUND_MANAGER.channel:push({
		type = 'sound_source',
		sound_code = snd.sound_code,
		data = NFS.read('data', snd.full_path),
		should_stream = snd.should_stream,
		per = snd.pitch,
		vol = snd.volume
	})
end

photochadfunkin = {
	--shared
	running = false,
	graphics = {
		arrows = {}
	},
	
	--song
	mania = 4, --corrosponds DIRECTLY to the number of keys (4 is 4, etc.)
	songOwner = "ellejokers",
	unspawnNoteIndex = false,
	conductor = {
		startTime = 0
	},
	
	--game settings
	downscroll = false,
	binds = {
		[4] = {{d = true, left = true}, {f = true, down = true}, {j = true, up = true}, {k = true, right = true}},
		[6] = {{s = true, z = true}, {d = true, x = true}, {f = true, c = true}, {j = true, left = true}, {k = true, down = true}, {l = true, right = true}},
		[7] = {{s = true, z = true}, {d = true, x = true}, {f = true, c = true}, {space = true}, {j = true, left = true}, {k = true, down = true}, {l = true, right = true}},
		[8] = {{a = true}, {s = true}, {d = true}, {f = true}, {j = true}, {k = true}, {l = true}, {[";"] = true}},
		[9] = {{a = true}, {s = true}, {d = true}, {f = true}, {space = true}, {j = true}, {k = true}, {l = true}, {[";"] = true}}
	},
	arroworder = {
		[4] = {1, 2, 3, 4},
		[6] = {1, 3, 4, 6, 2, 9},
		[7] = {1, 3, 4, 5, 6, 2, 9},
		[8] = {1, 2, 3, 4, 6, 7, 8, 9},
		[9] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
	},
	keyHolds = {false, false, false, false, false, false, false, false, false},
	
	--management
	start = function(self)
		if self.running then	return print("Tried to start FNF but it's already started!") end
		print("starting fnf, prepare your ass", self.mania)
		self.keyEvents = {}
		self.running = true
		self.score, self.health = 0, 1
		self.sicks, self.goods, self.bads, self.shits = 0, 0, 0, 0
		self.hits, self.misses, self.accuracy = 0, 0, 100
		for k = 1, self.mania do
			self.keyHolds[k] = false
		end
		
		self.conductor.bpm = self.song.bpm
		self.conductor.crochet = 60 / self.song.bpm
		self.conductor.stepCrochet = self.conductor.crochet * 0.25
		self.conductor.prevBeat = -99
		
		self:resize(love.graphics.getWidth(), love.graphics.getHeight())
		
		self.conductor.startTime = love.timer.getTime() + (self.conductor.crochet * 4) + 1
	end,
	formatSong = function(str)
		return ((str):lower()):gsub("%s", "-")
	end,
	loadSong = function(self, song, modName)
		self.song = assert(SMODS.load_file("lua/fnf/songs/"..song..".lua", modName))().song
		self.songOwner = modName or SMODS.current_mod.id
		return self:initSong(true)
	end,
	initSong = function(self, loadAudio)
		self.songPath = self.formatSong(self.song.song)
		if loadAudio then
			replaceSound("elle_stream_fnf_inst", self.songPath .. "-inst.ogg", self.songOwner)
			replaceSound("elle_stream_fnf_voices", self.songPath .. "-voices.ogg", self.songOwner)
			--[[SMODS.Sound {
				key = "stream_fnf_inst",
				path = self.songPath .. "-inst.ogg"
			}
			SMODS.Sound {
				key = "stream_fnf_voices",
				path = self.songPath .. "-voices.ogg"
			}]]
		end
		--Support multiple types of mania definition even tho only 1 chart format is (intentionally) supported rn
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
				if v2[4] ~= "scytheNote" then --lul
					self.unspawnNotes[#self.unspawnNotes + 1] = {
						v2[1] * 0.001, --Time (seconds)
						(v2[2] % self.mania) + 1, --Lane (starting from 1)
						(v2[2] >= self.mania) ~= mustHitSection, --True if note belongs to player
						v2[3] and (v2[3] * 0.001) or 0 --Sustain length (seconds)
					}
				end
			end
		end
		--sort notes by time
		table.sort(self.unspawnNotes, function(a, b)
			return a[1] < b[1]
		end)
		print("loaded "..tostring(#self.unspawnNotes).." notes")
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

for i, v in ipairs({"fnf_game", "fnf_menu"}) do
	assert(SMODS.load_file("lua/fnf/"..v..".lua"))()
end

photochadfunkin:loadSong("god-eater-hard")