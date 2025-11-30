local photochadfunkin, next = photochadfunkin, next --yes this is (still) an optimization
local config = SMODS.current_mod.config

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
	G.FUNCS.fun_fnf_test_song_select = function(args)
		--song_i = (song_i == #songs) and 1 or (song_i + 1)
		song_i = args.cycle_config.current_option
		print("Selected song: "..songs[song_i])
		photochadfunkin:loadSong(songs[song_i], "ellejokers")
	end

	G.FUNCS.fun_fnf_downscroll = function(e)
		--photochadfunkin.buttonevent = e
		photochadfunkin.downscroll = not photochadfunkin.downscroll
		photochadfunkin:resize(love.graphics.getWidth(), love.graphics.getHeight())
		config.fnf_downscroll = photochadfunkin.downscroll
		--print(photochadfunkin.downscroll and "Scroll is Down" or "Scroll is Up")
	end

	G.FUNCS.fun_fnf_keybinds = function(e)
		photochadfunkin:keybindmenu()
	end
	
	G.FUNCS.fun_fnf_start = function(e)
		photochadfunkin:start()
		print("Pressed the start button")
	end

	local UIBox_fnf_options = function()
		--local thing0 = UIBox_button({button = 'fun_fnf_test_song_select', label = {"TEST Song Select"}, minw = 5, focus_args = {snap_to = true}})
		local thing0 = create_option_cycle({opt_callback = "fun_fnf_test_song_select",
			label = "TEST Song Select",
			options = songs,
			current_option = song_i,
			w = 6
		})
		--local thing1 = UIBox_button({button = 'fun_fnf_downscroll', label = {"Downscroll"}, minw = 5, focus_args = {snap_to = true}})
		local thing1 = create_option_cycle({opt_callback = "fun_fnf_downscroll",
			options = {"Upscroll", "Downscroll"},
			current_option = photochadfunkin.downscroll and 2 or 1,
			w = 4
		})
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

	photochadfunkin.options = function(self, card)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = UIBox_fnf_options(),
		}
		if card then
			self.noteintro = {intro = true, cards = {}, card = card}
			for i = 1, self.mania do
				table.insert(self.noteintro.cards, {target = "arrowx", index = i, x = 0, y = 0, quad = self.graphics.noteQuads[1][i]})
			end
		end
	end
	
	G.FUNCS.photochadfunkin_options = function()
		photochadfunkin:options()
	end
	
	local textline = function(n, scale)
		return {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
			{n=G.UIT.T, config={text = n, scale = (4/7) * (scale or 1), colour = G.C.UI.TEXT_LIGHT, shadow = true}},
		}}
	end

	local UIBox_fnf_keybinds = function()
		local small_lol = 3/4
		local t = create_UIBox_generic_options({ contents = {
			textline("4 Key", small_lol),
			textline("DFJK / Arrow Keys"),
			textline("6 Key", small_lol),
			textline("SDFJKL / ZXC Left Down Right"),
			textline("7 Key", small_lol),
			textline("SDF SPACE JKL / ZXC SPACE Left Down Right"),
			textline("8 Key", small_lol),
			textline("ASDFJKL;"),
			textline("9 Key", small_lol),
			textline("ASDF SPACE JKL;"),
			--textline("Changing keybinds will come soon", 2/3)
		}, back_func = "photochadfunkin_options"})
		t.imstupidandfunkybitch = true
		return t
	end

	photochadfunkin.keybindmenu = function(self, card)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = UIBox_fnf_keybinds(),
		}
	end
end

--TODO: Is this needed
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