local photochadfunkin, next = photochadfunkin, next --yes this is an optimization

G.FUNCS.fun_fnf_downscroll = function(e)
	photochadfunkin.buttonevent = e
end

local UIBox_fnf_options = function()
  local thing1 = UIBox_button({button = 'fun_fnf_downscroll', label = {"Downscroll"}, minw = 5, focus_args = {snap_to = true}})
  local thing2 = UIBox_button({button = 'fun_fnf_keybinds', label = {'Keybinds'}, minw = 5, focus_args = {snap_to = true}})
  local thing3 = UIBox_button({button = 'fun_fnf_start', label = {'Start'}, minw = 5, focus_args = {snap_to = true}})

  local t = create_UIBox_generic_options({ contents = {
      thing1,
      thing2,
      thing3
    }})
  return t
end

photochadfunkin.options = function(self)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = UIBox_fnf_options(),
	}
end

photochadfunkin.resize = function(self, w, h)
	
end

photochadfunkin.update = function(self)
	local elapsed = love.timer.getDelta()
	local songPosition = love.timer.getTime() - self.startTime
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
			if v[2] == "p" then
				print("Start now :3")
				photochadfunkin:start()
			elseif v[2] == "u" then
				print("UI test")
				photochadfunkin.options()
			end
		end
	end
	
	if self.running then
		--Spawn notes
		if self.unspawnNoteIndex ~= false then
			while self.unspawnNotes[self.unspawnNoteIndex][1] - 5 > songPosition do
				self.notes[#self.notes + 1] = self.unspawnNotes[self.unspawnNoteIndex]
				print("note spawned at "..tostring(self.unspawnNotes[self.unspawnNoteIndex][1]))
				if self.unspawnNoteIndex == #self.unspawnNotes then
					self.unspawnNoteIndex = false
					print("no more notes to spawn")
					break
				end
				self.unspawnNoteIndex = self.unspawnNoteIndex + 1
			end
		end
	
		--Note misses/holds
	end
	photochadfunkin.keyEvents = {}
	
end

local _update = love.update
local everysooften = 0
function love.update(...)
	_update(...)
	
	photochadfunkin:update()
end