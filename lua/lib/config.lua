local palette_options = {}
for i, v in ipairs(ellejokers.palettes) do
	palette_options[#palette_options+1] = v.name
end
local palette_info = {"Palette by "..ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette].credit}


SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		emboss = 0.05,
		minh = 6,
		r = 0.1,
		minw = 6,
		align = "tm",
		padding = 0.2,
		colour = G.C.BLACK
	}, nodes = {
		create_toggle({opt_callback = "conf_elle_palette_toggle",
			label = "Palette Shader",
			ref_table = ellejokers.mod_data.config.pixel_shader,
			ref_value = 'enabled'
		}),
		create_option_cycle({opt_callback = "conf_elle_palette",
			label = "Palette",
			options = palette_options,
			current_option = ellejokers.mod_data.config.pixel_shader.palette,
			w = 5,
			scale = .8,
			config = {func = "conf_elle_palette_update"}
		}),
		{n=G.UIT.R, config={align = "cm"}, nodes={
			{n=G.UIT.T, config={text = "Palette by ", scale = 0.30, colour = G.C.WHITE}},
			{n=G.UIT.T, config={ref_table = ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette], ref_value = 'credit', scale = 0.30, colour = G.C.FILTER,func='conf_elle_palette_credit'}}
		}}
	}}
end

function G.FUNCS.conf_elle_palette(args)
	ellejokers.mod_data.config.pixel_shader.palette = args.cycle_config.current_option
end

function G.FUNCS.conf_elle_palette_toggle(args)
	ellejokers.mod_data.config.pixel_shader.enabled = not ellejokers.mod_data.config.pixel_shader.enabled
	check_for_unlock({type = "elle_toggle_palette"})
end

function G.FUNCS.conf_elle_palette_credit(args)
	args.config.ref_table = ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette]
end