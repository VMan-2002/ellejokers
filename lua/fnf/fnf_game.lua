local photochadfunkin, next = photochadfunkin, next --yes this is an optimization
local safeHit = 10 / 60

photochadfunkin.resize = function(self, w, h)
	w, h = w or 100, h or 100
	photochadfunkin.position = {
		width = w,
		height = h,
		halfwidth = w*0.5,
		halfheight = h*0.5,
		scale = h / 240,
		scroll = h * 1.4
	}
	local spacing = photochadfunkin.position.scale * 30
	local spacing2 = photochadfunkin.position.scale * ((56 / photochadfunkin.mania) + 16)
	local start = (w * 0.75) - (spacing2 * self.mania * 0.5)
	local Ostart = (w * 0.25) - (spacing2 * self.mania * 0.5)
	local arrowx = {}
	local arrowy = {photochadfunkin.position.scale * 6}
	if photochadfunkin.downscroll then
		arrowy[1] = h - spacing
		photochadfunkin.position.scroll = 0 - photochadfunkin.position.scroll
	end
	local arrowx2 = {}
	for i = 1, self.mania do
		arrowx[i] = start + (spacing2 * (i - 1))
		arrowx2[i] = Ostart + (spacing2 * (i - 1))
	end
	photochadfunkin.position.arrowx = arrowx
	photochadfunkin.position.Oarrowx = arrowx2
	photochadfunkin.position.arrowy = arrowy
	valatroingout.inspect("position", photochadfunkin.position)
end

do
	local gfx = {}
	local path = SMODS.current_mod.path .. "assets/gfx/"
	for k,v in pairs({
		"arrow0",
		"arrow1",
		"arrow2",
		"arrow3",
		"arrow4",
		"arrow5",
		"arrow6",
		"arrow7",
		"arrow8"
	}) do
		gfx[v] = love.graphics.newImage(NFS.read('data', path .. v .. ".png"))
	end
	photochadfunkin.graphics.arrows = {
		gfx.arrow0, gfx.arrow1, gfx.arrow2, gfx.arrow3, gfx.arrow4, gfx.arrow5, gfx.arrow6, gfx.arrow7, gfx.arrow8
	}
end

photochadfunkin:resize(love.graphics.getDimensions())
--valatroingout.inspect("a lol", photochadfunkin.size)

photochadfunkin.update = function(self)
	local elapsed = love.timer.getDelta()
	self.songPosition = love.timer.getTime() - self.conductor.startTime
	
	--Handle key events
	for k, v in pairs(photochadfunkin.keyEvents) do
		--v[1]: When the key was pressed (in seconds), relative to application start
		--v[2]: The KeyConstant that was pressed
		--v[3]: true if it was just pressed, false if it was just released
		local nkey = photochadfunkin:bindForKey(v[2])
		--print(v[1], v[2], v[3] and "press" or "release", nkey)
		if nkey then
			photochadfunkin.keyHolds[nkey] = v[3]
		elseif (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) and v[3] then
			if v[2] == "u" then
				print("UI test")
				photochadfunkin.options()
			end
		end
	end
	
	if self.running then
		local beat = self.songPosition / self.conductor.crochet
		if beat > self.conductor.prevBeat then
			--print("beat "..tostring(self.conductor.prevBeat))
			self.conductor.prevBeat = math.ceil(beat)
			if self.conductor.prevBeat == 1 then
				--TODO: it may actually be better to handle song audio on a custom thread?
				play_sound("elle_stream_fnf_inst")
				play_sound("elle_stream_fnf_voices")
			elseif self.conductor.prevBeat < 1 and self.conductor.prevBeat > -4 then
				play_sound("elle_fnf_intro" .. tostring(0 - self.conductor.prevBeat))
			end
		end
		--Spawn notes
		if self.unspawnNoteIndex ~= false then
			while self.unspawnNotes[self.unspawnNoteIndex][1] - 5 < self.songPosition do
				self.notes[#self.notes + 1] = self.unspawnNotes[self.unspawnNoteIndex]
				--print("note spawned at "..tostring(self.unspawnNotes[self.unspawnNoteIndex][1]))
				if self.unspawnNoteIndex == #self.unspawnNotes then
					self.unspawnNoteIndex = false
					print("no more notes to spawn")
					break
				end
				self.unspawnNoteIndex = self.unspawnNoteIndex + 1
			end
		end
		--Despawn notes
		if next(self.notes) then
			while self.notes[1][1] + safeHit < self.songPosition do
				table.remove(self.notes, 1)
				--print("despawn note")
				if not next(self.notes) then break end
			end
		end
	
		--Note misses/holds
	end
	photochadfunkin.keyEvents = {}
end

local function arroworder(n)
	return photochadfunkin.arroworder[photochadfunkin.mania][n]
end

--idk how to do the balatro sprites. but i do know how to do this. now, is that bad?
photochadfunkin.draw = function(self)
	love.graphics.setColor(1, 1, 1, 1)
	--[[if self.running then
		local w, h = love.graphics.getDimensions()
		love.graphics.rectangle("fill", 0, 0, (1 + math.sin(love.timer.getTime() * 2)) * w * 0.5, h)
	end]]
	if self.running then
		for i = 1, self.mania do
			love.graphics.draw(self.graphics.arrows[arroworder(i)], self.position.arrowx[i], self.position.arrowy[1], 0, self.position.scale)
			love.graphics.draw(self.graphics.arrows[arroworder(i)], self.position.Oarrowx[i], self.position.arrowy[1], 0, self.position.scale)
			for k,v in pairs(self.notes) do
				love.graphics.draw(
					self.graphics.arrows[arroworder(v[2])],
					self.position[v[3] and "arrowx" or "Oarrowx"][v[2]],
					self.position.arrowy[1] - ((self.songPosition - v[1]) * self.position.scroll),
					0,
					self.position.scale
				)
			end
		end
	end
end

local _update = love.update
function love.update(...)
	_update(...)
	
	photochadfunkin:update()
end

local _draw = love.draw
function love.draw(...)
	_draw(...)
	
	photochadfunkin:draw()
end