local photochadfunkin, next = photochadfunkin, next --yes this is an optimization
local safeHit = 10 / 60
local transform1 = love.math.newTransform()
local transformtemp = function(a, b) return (b or transform1):setMatrix(a:getMatrix()) end
local lerp = function(a,b,t) return (1-t)*a + t*b end

photochadfunkin.resize = function(self, w, h)
	w, h = w or 100, h or 100
	self.position = {
		width = w,
		height = h,
		halfwidth = w*0.5,
		halfheight = h*0.5,
		scale = h / 240,
		scroll = h / 2.84,
		scoretxy = h - 100,
		hold = 1,
		holdend = 2,
		songpos = self.debug and 50 or 0,
		viewTransform = love.math.newTransform(),
		tShadDist = h * 0.003,
		strumscale = {},
		ostrumscale = {}
	}
	local spacing = self.position.scale * 30
	local spacing2 = self.position.scale * math.ceil((58 / self.mania) + 14)
	local start = (w * 0.75) - (spacing2 * self.mania * 0.5)
	local Ostart = (w * 0.25) - (spacing2 * self.mania * 0.5)
	local arrowx = {}
	local arrowy = self.position.scale * 18
	if self.downscroll then
		arrowy = h - arrowy
		self.position.scroll = 0 - self.position.scroll
		self.position.scoretxy = 70
		self.position.hold = 3
		self.position.holdend = 4
	end
	if self.song then
		self.position.scroll = self.position.scroll * self.song.speed
	end
	local arrowx2 = {}
	local ib
	local middle = self.graphics.noteMiddle
	self.position.middler = middle * self.position.scale
	self.position.middleg = middle
	for i = 1, self.mania do
		ib = i - 1
		arrowx[i] = start + (spacing2 * (i - 1)) + self.position.middler
		arrowx2[i] = Ostart + (spacing2 * (i - 1)) + self.position.middler
		--[[strums[i] = love.math.newTransform(start + (spacing2 * ib) + self.position.middler, arrowy + self.position.middler, 0, self.position.scale, self.position.scale, 12, 12)
		ostrums[i] = love.math.newTransform(Ostart + (spacing2 * ib) + self.position.middler, arrowy + self.position.middler, 0, self.position.scale, self.position.scale, 12, 12)]]
		self.position.strumscale[i] = 1
		self.position.ostrumscale[i] = 1
	end
	self.position.arrowx = arrowx
	self.position.Oarrowx = arrowx2
	self.position.arrowy = arrowy
	--valatroingout.inspect("position", self.position)
	
	self.position.viewTransform:setTransformation(0, 0, 0, self.position.scale, self.position.scale)
	
	if self.running then
		self.font = love.graphics.newFont("resources/fonts/m6x11plus.ttf", h * 0.04)
	end
end

photochadfunkin.updateScoreHud = function(self)
	local mult = tostring(math.max(self.multBase - (self.misses * 0.1), 1))
	self.scoreHudText = "Hits: "..tostring(self.hits).." | Misses: "..tostring(self.misses).." | Mult: X"..mult.." | Accuracy: TBA"
end

--[[local spritebatchNotes, spritebatchHolds
do
	local gfx = {}
	local path = SMODS.current_mod.path .. "assets/gfx/"
	for k,v in pairs({
		arrows = "arrowsnew",
		holds = "holdsnew"
	}) do
		gfx[k] = love.graphics.newImage(NFS.read('data', path .. v .. ".png"))
		gfx[k]:setFilter("linear", "nearest")
	end
	photochadfunkin.graphics.arrowsSheet = gfx.arrows
	photochadfunkin.graphics.holdsSheet = gfx.holds
	photochadfunkin.graphics.noteQuads = {{}, {}, {}, {}}
	photochadfunkin.graphics.holdQuads = {{}, {}, {}, {}}
	spritebatchNotes = love.graphics.newSpriteBatch(gfx.arrows)
	spritebatchHolds = love.graphics.newSpriteBatch(gfx.holds)
	local tx, ty = gfx.arrows:getDimensions()
	local htx, hty = gfx.holds:getDimensions()
	local sizer = {
		--note tile size
		31, 31,
		--hold tile size
		8, 5
	}
	for i = 1, 9 do
		local x = (i-1)*sizer[1]
		local hx = (i-1)*sizer[3]
		for i2 = 1, 4 do
			photochadfunkin.graphics.noteQuads[i2][i] = love.graphics.newQuad(x, (i2-1)*sizer[2], sizer[1], sizer[2], tx, ty)
			photochadfunkin.graphics.holdQuads[i2][i] = love.graphics.newQuad(hx, (i2-1)*sizer[4], sizer[3], sizer[4], htx, hty)
		end
	end
end]]

photochadfunkin:resize(love.graphics.getDimensions())
--valatroingout.inspect("a lol", photochadfunkin.size)

photochadfunkin.update = function(self)
	local elapsed = love.timer.getDelta()
	self.songPosition = love.timer.getTime() - self.conductor.startTime
	
	--Handle key events
	for k, v in pairs(self.keyEvents) do
		if (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) and v[3] then
			if v[2] == "u" then
				print("UI test")
				self:options()
			end
		end
	end
	
	if self.running then
		--Conductor
		local beat = self.songPosition / self.conductor.crochet
		if beat > self.conductor.prevBeat then
			--print("beat "..tostring(self.conductor.prevBeat))
			self.conductor.prevBeat = math.ceil(beat)
			if self.conductor.prevBeat == 1 then
				--TODO: it may actually be better to handle song audio on a custom thread?
				--or just lovely patch the audio manager
				play_sound("elle_stream_fnf_inst")
				play_sound("elle_stream_fnf_voices")
			elseif self.conductor.prevBeat < 1 and self.conductor.prevBeat > -4 then
				play_sound("elle_fnf_intro" .. tostring(0 - self.conductor.prevBeat))
			end
			for k,v in pairs(self.characters) do
				if (v.idle and (beat % 2 == 0)) or v.curAnimTime > self.conductor.crochet * 1.99 then
					self:characterDance(v)
				end
			end
		end
		--Spawn notes
		if self.unspawnNoteIndex ~= false then
			while self.unspawnNotes[self.unspawnNoteIndex][1] - 5 < self.songPosition do
				self.notes[#self.notes + 1] = self.unspawnNotes[self.unspawnNoteIndex]
				--print("note spawned at "..tostring(self.unspawnNotes[self.unspawnNoteIndex][1]))
				if self.unspawnNoteIndex == #self.unspawnNotes then
					self.unspawnNoteIndex = false
					--print("no more notes to spawn")
					break
				end
				self.unspawnNoteIndex = self.unspawnNoteIndex + 1
			end
		end
		--Despawn notes
		if next(self.notes) then
			local i = 1
			while self.notes[i][1] < self.songPosition do
				if self.notes[i][3] then
					if self.notes[i][1] + safeHit < self.songPosition then
						table.remove(self.notes, i)
						self.misses = self.misses + 1
						self:updateScoreHud()
						goto continue1
					end
				elseif self.notes[i][1] < self.songPosition then
					self:characterPlayAnim(self.characters[1], "sing" .. self.arrowdirs[self.notes[i][2]], true)
					table.remove(self.notes, i)
					goto continue1
				end
				i = i + 1
				::continue1::
				if i > #self.notes then break end
			end
		end
		
		--Handle key events
		for k, v in pairs(self.keyEvents) do
			--v[1]: When the key was pressed (in seconds), relative to application start
			--v[2]: The KeyConstant that was pressed
			--v[3]: true if it was just pressed, false if it was just released
			local nkey = self:bindForKey(v[2])
			--print(v[1], v[2], v[3] and "press" or "release", nkey)
			if nkey then
				if v[3] then
					self.keyHolds[nkey] = 2
					self.position.strumscale[nkey] = 0.85
					--Try to hit a note
					for k,v in ipairs(self.notes) do
						if (v[3]) and (nkey == v[2]) and (math.abs(self.songPosition - v[1]) <= safeHit) then
							--Note is hit
							--print("Hit note",v[1],self.songPosition,math.abs(self.songPosition - v[1]))
							table.remove(self.notes, k)
							self.hits = self.hits + 1
							self.keyHolds[nkey] = 4
							self:updateScoreHud()
							self.position.strumscale[nkey] = 1.3
							break
						end
					end
				else
					self.keyHolds[nkey] = 1
				end
			end
		end
		
		for k,v in pairs(self.characters) do
			v.curAnimTime = v.curAnimTime + elapsed
		end
		
		for i = 1, self.mania do
			self.position.strumscale[i] = lerp(self.position.strumscale[i], 1, elapsed * 12)
		end
	
		--Note misses/holds
	end
	if self.noteintro.intro then
		if G.OVERLAY_MENU and G.OVERLAY_MENU.definition.imstupidandfunkybitch then
		
		else
		
		end
	end
	self.keyEvents = {}
end

local function arroworder(n)
	return photochadfunkin.arroworder[photochadfunkin.mania][n]
end

--idk how to do the balatro sprite objects. but i do know how to do this. now, is that bad?
photochadfunkin.draw = function(self)
	love.graphics.setColor(1, 1, 1, 1)
	--[[if self.running then
		local w, h = love.graphics.getDimensions()
		love.graphics.rectangle("fill", 0, 0, (1 + math.sin(love.timer.getTime() * 2)) * w * 0.5, h)
	end]]
	if self.running then
		-- local oldshad = love.graphics.getShader()
		--self.fuckassshader
		-- love.graphics.setShader(self.fuckassshader)
		--self.fuckassshader:send()
		for _,v in ipairs(self.characters) do
			local frame = v.def.anims[v.curAnim][math.min(math.floor(v.curAnimTime * 24) + 1, #v.def.anims[v.curAnim])]
			love.graphics.draw(v.image, v.def.quads[frame], transformtemp(v.position):apply(self.position.viewTransform))
		end
		-- love.graphics.setShader()
		
		for i = 1, self.mania do
			self.graphics.spritebatchNotes:add(
				self.graphics.noteQuads[self.keyHolds[i]][arroworder(i)],
				self.position.arrowx[i], self.position.arrowy,
				0,
				self.position.scale * self.position.strumscale[i], nil,
				self.position.middleg, self.position.middleg
			)
			self.graphics.spritebatchNotes:add(
				self.graphics.noteQuads[1][arroworder(i)],
				self.position.Oarrowx[i], self.position.arrowy,
				0, 
				self.position.scale, nil,
				self.position.middleg, self.position.middleg
			)
			for k,v in pairs(self.notes) do
				self.graphics.spritebatchNotes:add(
					self.graphics.noteQuads[3][arroworder(v[2])],
					(v[3] and self.position.arrowx or self.position.Oarrowx)[v[2]],
					self.position.arrowy - ((self.songPosition - v[1]) * self.position.scroll),
					0, self.position.scale, nil,
					self.position.middleg, self.position.middleg
				)
				--[[love.graphics.printf(
					v[1],
					self.font,
					self.position[v[3] and "arrowx" or "Oarrowx"][v[2] ],
					self.position.arrowy - ((self.songPosition - v[1]) * self.position.scroll),
					self.position.width
				)]]
			end
		end
		love.graphics.draw(self.graphics.spritebatchNotes)
		self.graphics.spritebatchNotes:clear()
		love.graphics.printf(
			self.songPosition,
			self.font,
			0, self.position.songpos,
			self.position.width
		)
		love.graphics.printf({G.C.UI.HOVER, self.scoreHudText}, self.font, self.position.tShadDist, self.position.scoretxy + self.position.tShadDist, self.position.width, "center")
		love.graphics.printf(self.scoreHudText, self.font, 0, self.position.scoretxy, self.position.width, "center")
		
		-- love.graphics.setShader(oldshad)
	elseif self.noteintro.intro then
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