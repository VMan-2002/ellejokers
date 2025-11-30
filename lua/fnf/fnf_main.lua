--New FNF Mod
--look inside
--photochad

--this wacky (wip) bs was coded by vman_2002

--[[
	TODO:
	
	Hold notes
	Health & Game Over
	Full options menu
	Boss blinds
	Cool intro thingy where the strumnotes come out from the Joker or Boss Blind, like how cards are drawn from deck into hand
]]
local config = SMODS.current_mod.config

for k, v in pairs({
	stream_fnf_inst = "carpet.ogg",
	stream_fnf_voices = "carpet.ogg",
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
	local data = NFS.read('data', snd.full_path)
	G.SOUND_MANAGER.channel:push({
		type = 'sound_source',
		sound_code = snd.sound_code,
		data = data,
		should_stream = snd.should_stream,
		per = snd.pitch,
		vol = snd.volume
	})
	return data
end

photochadfunkin = {
	--shared
	running = false,
	graphics = {
		arrows = {}
	},
	multBase = 3,
	multPerMiss = 0.1,
	multMinimum = 1,
	multOnLoss = 0.5,
	gfxData = function(file, mod)
		return NFS.read('data', (SMODS.Mods[mod] or SMODS.current_mod).path .. "assets/gfx/" .. file .. ".png")
	end,
	noteintro = {},
	debug = SMODS.Mods.DebugPlus and not SMODS.Mods.DebugPlus.disabled,
	
	--song
	mania = 4, --corrosponds DIRECTLY to the number of keys (4 is 4, etc.)
	songOwner = "ellejokers",
	unspawnNoteIndex = false,
	conductor = {
		startTime = 0
	},
	
	--game settings
	downscroll = (config.fnf_downscroll ~= nil) and config.fnf_downscroll or false,
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
	arrowdirs = { "LEFT", "DOWN", "UP", "RIGHT", "UP", "LEFT", "DOWN", "UP", "RIGHT" },
	keyHolds = {1, 1, 1, 1, 1, 1, 1, 1, 1},
	
	--management
	start = function(self)
		if self.running then	return print("Tried to start FNF but it's already started!") end
		print("starting fnf, prepare your ass", self.mania)
		self.keyEvents = {}
		self.running = true
		self.score, self.health = 0, 1
		self.maxHealth = 2
		self.sicks, self.goods, self.bads, self.shits = 0, 0, 0, 0
		self.hits, self.misses, self.accuracy = 0, 0, 100
		for k = 1, self.mania do
			self.keyHolds[k] = 1
		end
		
		self.conductor.bpm = self.song.bpm
		self.conductor.crochet = 60 / self.song.bpm
		self.conductor.stepCrochet = self.conductor.crochet * 0.25
		self.conductor.prevBeat = -99
		
		self:resize(love.graphics.getWidth(), love.graphics.getHeight())
		self:updateScoreHud()
		
		self.conductor.startTime = love.timer.getTime() + (self.conductor.crochet * 4) + 1
		
		self.characters = {self:createCharacter("bf", "ellejokers", self.jokerEdition)}
		self.songinfo = self.song.song .. " | ellejokers " .. SMODS.Mods.ellejokers.version
		
		G.CONTROLLER.locks.frame = true
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
			local instData = replaceSound("elle_stream_fnf_inst", self.songPath .. "-inst.ogg", self.songOwner)
			replaceSound("elle_stream_fnf_voices", self.songPath .. "-voices.ogg", self.songOwner)
			self.songLength = love.audio.newSource(instData, "stream"):getDuration()
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
	
	--characters
	getCharacterID = function(name, mod)
		return (SMODS.Mods[mod] or SMODS.current_mod).prefix .. "_" .. name
	end,
	loadCharacter = function(self, name, mod)
		local id = self.getCharacterID(name, mod)
		if self.characterDefs[id] then return print("Character Def "..tostring(id).." already loaded") end
		local ch = assert(SMODS.load_file("lua/fnf/chars/"..name..".lua", mod))()
		self.characterDefs[id] = ch
		ch.image = love.graphics.newImage(self.gfxData(ch.imageFile))
		ch.image:setFilter("linear", "nearest")
		ch.editionImage = {}
		local tx, ty = ch.image:getDimensions()
		local quads = {}
		ch.quads = quads
		for _,v in pairs(ch.anims) do
			for _,v2 in pairs(v) do
				if not quads[v2] then
					quads[v2] = love.graphics.newQuad(
						((v2 - 1) % ch.xtiles) * ch.xtilesize,
						math.floor((v2 - 1) / ch.xtiles) * ch.ytilesize,
						ch.xtilesize, ch.ytilesize,
						tx, ty
					)
				end
			end
		end
		ch.danceType = ch.anims.danceLeft
	end,
	createCharacter = function(self, name, mod, edition)
		local def = self.characterDefs[self.getCharacterID(name, mod)]
		local img = def.image
		if edition then
			--using shader is better most of the time
			if def.editionImage[edition] ~= nil then
				img = def.editionImage[edition]
			elseif def.editionImage[edition] ~= false then
				def.editionImage[edition] = false
				for k, v in pairs(SMODS.Mods) do
					if not v.disabled then
						if pcall(function()
							def.editionImage[edition] = love.graphics.newImage(self.gfxData(def.imageFile .. "_" .. edition, k))
							img = def.editionImage[edition]
							img:setFilter("linear", "nearest")
						end) then break end
					end
				end
			end
		end
		return {
			def = def,
			curAnim = def.danceType and "danceLeft" or "idle",
			curAnimTime = 0,
			position = love.math.newTransform(),
			idle = true,
			danced = true,
			image = img
		}
	end,
	characterDefs = {},
	characters = {},
	characterPlayAnim = function(self, ch, name, force)
		if force or ch.curAnim ~= name then
			ch.curAnim = name
			ch.curAnimTime = 0
			ch.idle = false
		end
	end,
	characterDance = function(self, ch)
		ch.danced = not ch.danced
		self:characterPlayAnim(ch, ch.def.danceType and (ch.danced and "danceRight" or "danceLeft") or "idle", true)
		ch.idle = true
	end,
	
	--game
	bindForKey = function(self, n)
		for k,v in pairs(self.binds[self.mania]) do
			--vn like visual novel lolol
			if v[n] then return k end
		end
		return nil
	end,
	keyEvents = {},
	
	loadNoteskin = function(self, name, mod)
		local ch = assert(SMODS.load_file("lua/fnf/noteskins/"..name..".lua", mod))()
		
		local gfx = {}
		for k,v in pairs({
			arrows = ch.arrows,
			holds = ch.holds
		}) do
			gfx[k] = love.graphics.newImage(self.gfxData(v, mod))
			gfx[k]:setFilter("linear", "nearest")
		end
		self.graphics.arrowsSheet = gfx.arrows
		self.graphics.holdsSheet = gfx.holds
		self.graphics.noteQuads = {{}, {}, {}, {}}
		self.graphics.holdQuads = {{}, {}, {}, {}}
		self.graphics.spritebatchNotes = love.graphics.newSpriteBatch(gfx.arrows)
		self.graphics.spritebatchHolds = love.graphics.newSpriteBatch(gfx.holds)
		local tx, ty = gfx.arrows:getDimensions()
		local htx, hty = gfx.holds:getDimensions()
		local sizer = {
			--note tile size
			ch.arrowtilew or 24, ch.arrowtileh or 24,
			--hold tile size
			ch.holdtilew or 8, ch.holdtileh or 5
		}
		self.graphics.noteMiddle = ch.arrowtilew * 0.5
		for i = 1, ch.arrowcount or 9 do
			local x = (i-1)*sizer[1]
			local hx = (i-1)*sizer[3]
			for i2 = 1, 4 do
				self.graphics.noteQuads[i2][i] = love.graphics.newQuad(x, (i2-1)*sizer[2], sizer[1], sizer[2], tx, ty)
				self.graphics.holdQuads[i2][i] = love.graphics.newQuad(hx, (i2-1)*sizer[4], sizer[3], sizer[4], htx, hty)
			end
		end
	end,
	stop = function(this, fn)
		G.CONTROLLER.locks.frame = false
		self.running = false
		if fn then fn(self) end
		self.onWin, self.onLose = nil, nil
	end,
	
	accepted_blinds = {bl_elle_microphone = true, bl_elle_microphone_showdown = true},
	
	--fuckassshader = G.SHADERS.polychrome
}
photochadfunkin:loadCharacter("bf", "ellejokers")
photochadfunkin:loadNoteskin("cardgame", "ellejokers")

local bclick = Blind.click
function Blind.click(self, ...) 
	if photochadfunkin.accepted_blinds[self.name] and not G.GAME.blind.photochadfunkin_completed then
		return photochadfunkin:options(self)
	end
	bclick(self, ...)
end

for i, v in ipairs({
	"fnf_game",
	"fnf_menu",
	"fnf_blinds"
}) do
	assert(SMODS.load_file("lua/fnf/"..v..".lua"))()
end

photochadfunkin:loadSong("god-eater-hard")