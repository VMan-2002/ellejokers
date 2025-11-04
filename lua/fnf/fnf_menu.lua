local photochadfunkin, next = photochadfunkin, next --yes this is (still) an optimization

do -- Options
	local songs = {
		"god-eater-hard",
		"god-eater-easy",
		"thunderstorm-hard",
		"thunderstorm-easy",
		"extirpatient-hard",
		"extirpatient-hell"
	}
	local song_i = 1
	G.FUNCS.fun_fnf_test_song_select = function(e)
		song_i = (song_i == #songs) and 1 or (song_i + 1)
		print("Selected song: "..songs[song_i])
		photochadfunkin:loadSong(songs[song_i], "ellejokers")
	end

	G.FUNCS.fun_fnf_downscroll = function(e)
		photochadfunkin.buttonevent = e
		photochadfunkin.downscroll = not photochadfunkin.downscroll
		print(photochadfunkin.downscroll and "Scroll is Down" or "Scroll is Up")
	end

	G.FUNCS.fun_fnf_keybinds = function(e)
		print("Changing keybinds not yet implemented")
		print("4 Key: DFJK / Arrows")
		print("6 Key: SDFJKL / ZXC Left Down Right")
		print("7 Key: SDF SPACE JKL / ZXC SPACE Left Down Right")
		print("8 Key: ASDFJKL;")
		print("9 Key: ASDF SPACE JKL;")
	end
	
	G.FUNCS.fun_fnf_start = function(e)
		photochadfunkin:start()
		print("Pressed the start button")
	end

	local UIBox_fnf_options = function()
		local thing0 = UIBox_button({button = 'fun_fnf_test_song_select', label = {"TEST Song Select"}, minw = 5, focus_args = {snap_to = true}})
		local thing1 = UIBox_button({button = 'fun_fnf_downscroll', label = {"Downscroll"}, minw = 5, focus_args = {snap_to = true}})
		local thing2 = UIBox_button({button = 'fun_fnf_keybinds', label = {'Keybinds'}, minw = 5, focus_args = {snap_to = true}})
		local thing3 = UIBox_button({button = 'fun_fnf_start', label = {'Start'}, minw = 5, focus_args = {snap_to = true}})

		local t = create_UIBox_generic_options({ contents = {
			thing0,
			thing1,
			thing2,
			thing3
		}})
		t.imstupidandfunkybitch = true
		return t
	end

	photochadfunkin.options = function(self)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = UIBox_fnf_options(),
		}
	end
end

do -- Game View
	local UIBox_fnf_gameview = function()
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

	photochadfunkin.gameview = function(self)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = UIBox_fnf_gameview(),
		}
	end
end