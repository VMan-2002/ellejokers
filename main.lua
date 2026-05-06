--		[[ To-Do List ]]
--	- New Joker art
--		- Chloe
--		- Furry
--		- Marie
--		- Twy
--		- Elle
--		- Mint
--		- Drago
--	- More Jokers????
--		- Ideas
--			- Deck with showman effect
--			- Jokers
--				- Unnamed Joker Idea
--					- If Scoring Hand contains a Straight, give all cards in hand a permanent +4 Mult
--		- pls don't scope creep i swear to god-
--			- oops too late hehe~
--	- Needs effects
--		- Unimplemented
--			- Spearmint/spearmint.prog
--				- Skill tree?
--				- Allocatable points from beating blinds?
--					- More points from boss blinds (3?)
--			- Boyfriend
--				- LITERALLY JUST FNF - VMan's working on this :p
--				- Balatro SFX atonals similar to SCDM
--	- "The Microphone" boss blind
--		- Also FNF, like Boyfriend
--		- Plays a harder fnf song
--		- "Zoinks!" final boss blind
--			- 9k song, on par with (or literally just) Final Destination
--	- Fix Bugs
--		- MoreFluff
--			- Custom Colour card crashes game on round end

ellejokers = {
	mod_data = SMODS.current_mod,
	palettes = {
		{
			name = "octo80",
			path = "octo80.png",
			credit = "octoshrimpy"
		},
		{
			name = "AAP-64",
			path = "aap64.png",
			credit = "Adigun A. Polack"
		},
		{
			name = "Greyscale (octo80)",
			path = "greyscale.png",
			credit = "octoshrimpy"
		},
		{
			name = "Binary",
			path = "binary.png",
			credit = "???"
		},
		{
			name = "Balatro...?",
			path = "balatro.png",
			credit = "???"
		}
	},
	censor_atlases = {
		"elle_censor_default",
		"elle_censor_bar",
		"elle_censor_featureless"
	},
	calculate = {},
	reset_game_globals = {}
}

-- Create palettes
for k, v in ipairs(ellejokers.palettes) do
	v.image = love.graphics.newImage( love.image.newImageData(SMODS.NFS.newFileData( SMODS.current_mod.path .. "assets/extra_images/palettes/"..v.path) ) )
	local w,h = v.image:getDimensions()
	v.dims = {w,h}
end


--		[[ File List ]]
local lib = {
	"skins",
	"consumables",
	"misc",
	"http",
	"challenges",
	"popup_shop",
	"enhancements",
	"blindside",
	"morefluff",
	"achievements",
	"config",
	"tv_time",
	"final_episode",
	"decks"
}

--		[[ Joker List ]]
-- Using this to make sure the groups are in order
local joker_groups = {
	"mall",
	"crossovers",
	"waterbucketrelease",
	"misc",
	"gimmicks",
	"legendaries"
}
-- Comment out jokers you want to disable
local jokers = {
	-- Canon OCs
	mall = {
		"chloe",
		"furry",
		"cheshire",
		"sophie",
		"fallen angel",
		"sarah",
		"mint",
		--"spearmint.prog",
		--"spearmint",
		"spearlamp",
		"marie",
		"bea",
		"rebecca",
		"cassie",
		--"cassie_stasis",
		--"not_cassie",
		"41",
		"prototypes"
	},

	-- Friends & Partners
	crossovers = {
		"drago",
		"cheshdrago",
		"vivian",
		"jess",
		"jessclip",
		"jessingit",
		"feri",
		"ferisophie"
	},

	-- Jess's Minecraft Idea
	waterbucketrelease = {
		"cobble_gen",
		"water_bucket",
		"lava_bucket",
		"cobblestone",
		"obsidian"
	},

	-- Random shit :)
	misc = {
		"diamond_pickaxe",
		"carpet",
		"spamton",
		"polyamory",
		--"bf",
		"ourple",
		"nitro",
		"eraser",
		"magic_fingers",
		"suggestion",
		"powerscaler",
		"clubcard",
		"combat",
		"batcreditcard"
	},

	-- Gimmicky shit :33
	gimmicks = {
		"wordle",
		"tenna"
	},

	-- Legendaries
	legendaries = {
		"twy",
		"elle"
	}
}

--#region Atlases
SMODS.Atlas{
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
}
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "nsfw",
	path = "nsfw.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "animated",
	path = "animated.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "legendary",
	path = "legendary.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "consumables",
	path = "consumables.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "enhancers",
	path = "enhancers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "vouchers",
	path = "vouchers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "tag",
	path = "tags.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = "blinds",
	path = "blinds.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21
}
SMODS.Atlas {
	key = "cornericons",
	path = "cornericons.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = "crossover_icon",
	path = "crossover_icon.png",
	px = 50,
	py = 50
}
SMODS.Atlas {
	key = "lamps",
	path = "lamps.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "censor_default",
	path = "censorship/default.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "censor_bar",
	path = "censorship/bar.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "censor_featureless",
	path = "censorship/featureless.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "tenna_its_tv_time",
	path = "tenna_its_tv_time.png",
	px = 505,
	py = 141,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 2,
	fps = 4
}
SMODS.Atlas {
	key = "tenna_physical_challenge",
	path = "tenna_physical_challenge.png",
	px = 391,
	py = 69,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 18,
	fps = 30
}
--#endregion

--#region Sounds
SMODS.Sound {
	key = "carpet",
	path = "carpet.ogg"
}
SMODS.Sound {
	key = "fizz",
	path = "fizz.ogg"
}
SMODS.Sound {
	key = "squeak",
	path = "squeak.ogg"
}
SMODS.Sound {
	key = "music_spamton",
	path = "music_spamton.ogg",
	sync = false,
	pitch = 1
}
SMODS.Sound {
	key = "music_tvtime",
	path = "music_tvtime.ogg",
	 sync = {
		['elle_music_tvtime'] = true,
		['elle_music_tvtime_guitar'] = true
	},
	pitch = 1
}
SMODS.Sound {
	key = "music_tvtime_guitar",
	path = "music_tvtime_guitar.ogg",
	 sync = {
		['elle_music_tvtime'] = true,
		['elle_music_tvtime_guitar'] = true
	},
	select_music_track = function()
		return #SMODS.find_card("j_elle_tenna", false)>0 and ellejokers.tvtime.running and ellejokers.tvtime.microgame and ellejokers.tvtime.microgame.rhythm_layer
	end,
	pitch = 1
}
SMODS.Sound {
	key = "tenna_jump",
	path = "tenna_jump.ogg"
}
SMODS.Sound {
	key = "tenna_land",
	path = "tenna_land.ogg"
}
SMODS.Sound {
	key = "utdr_hurt",
	path = "utdr_hurt.ogg"
}
--#endregion

--#region Font stuff
SMODS.Font {
    key = "Determination",
    path = "determination_mono.otf",
    render_scale = 100,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = {x=0,y=0},
    FONTSCALE = 0.1,
    squish = 1,
    DESCSCALE = 1
}
-- Make this version for Tenna microgames 
ellejokers.undertale_font = love.graphics.newFont(SMODS.NFS.newFileData( SMODS.current_mod.path .. "assets/fonts/determination_mono.otf"),13,"mono")
--#endregion

--		[[ Config / Optional Features ]]
-- Optional Features
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true, quantum_enhancements = true }
end

-- Text Colours
loc_colour('red')
G.ARGS.LOC_COLOURS.elle = HEX('FF53A9')

-- Badges
elle_badges = {
	mall = {
		text = "The Mall",
		colour = HEX('b7a2fd')
	},
	friends = {
		text = "Friends of Elle",
		colour = HEX('40aeff')
	},
	poly = {
		text = "Girlfriends of Elle",
		colour = HEX('81cefd')
	}
}

-- Add joker animations
local upd = Game.update
anim_elle_spearmint_dt = 0
anim_elle_spearmint_f = 0
anim_elle_spearmint_spd = 0.25
function Game:update(dt)
	upd(self,dt)
	anim_elle_spearmint_dt = anim_elle_spearmint_dt + dt
	if G.P_CENTERS and anim_elle_spearmint_dt > anim_elle_spearmint_spd then
		local _f = math.floor(anim_elle_spearmint_dt / anim_elle_spearmint_spd)
		anim_elle_spearmint_dt = anim_elle_spearmint_dt % anim_elle_spearmint_spd
		
		-- spearmint.prog animation
		if G.P_CENTERS.j_elle_spearmintprog then
			local obj = G.P_CENTERS.j_elle_spearmintprog
			obj.pos.x = (obj.pos.x + _f) % 2
		end
		
		-- Spearmint animation
		if G.P_CENTERS.j_elle_spearmint then
			local obj = G.P_CENTERS.j_elle_spearmint
			anim_elle_spearmint_f = (anim_elle_spearmint_f + _f) % 4 -- Taking extra steps to ping-pong the middle frame
			obj.pos.x = anim_elle_spearmint_f > 2 and 2-(anim_elle_spearmint_f-2) or anim_elle_spearmint_f
		end
		
		-- Check It Out animation
		if G.P_CENTERS.j_elle_carpet then
			local obj = G.P_CENTERS.j_elle_carpet
			obj.pos.x = (obj.pos.x + _f) % 2
		end
	end
end

for i, v in ipairs(lib) do
	assert(SMODS.load_file("lua/misc/"..v..".lua"))()
end

for _, v in ipairs(joker_groups) do
	for _, v2 in ipairs(jokers[v]) do
		assert(SMODS.load_file("lua/jokers/"..v.."/"..v2..".lua"))()
	end
end

SMODS.current_mod.calculate = function(self,context)
	for k, v in pairs(ellejokers.calculate) do
		v(context)
	end
end

SMODS.current_mod.reset_game_globals = function(run_start)
	for k, v in pairs(ellejokers.reset_game_globals) do
		v(run_start)
	end
end


if SMODS.ScreenShader then
	SMODS.Shader {
		key = "pixelated",
		path = "pixelated.fs"
	}
	
	SMODS.ScreenShader {
		key = "pixelated",
		shader = "elle_pixelated", --modprefix is necessary, this now refers to the same shader defined above

		send_vars = function(self)
			local p = ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette]
			local w,h = love.graphics.getDimensions()
			return {
				palette = p.image,
				paletteSize = p.dims,
				dims = {w/2,h/2}
			}
		end,
		should_apply = function(self)
			return ellejokers.mod_data.config.pixel_shader.enabled
		end,
		order = 1
	}
else
	SMODS.Shader {
		key = 'pixelated_fallback',
		path = 'pixelated_fallback.fs',

		send_vars = function(self, sprite, card)
			local p = ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette]
			return {
				palette = p.image,
				paletteSize = p.dims
			}
		end
	}

	SMODS.DrawStep {
		key = "elle_pixelated",
		order = 15,
		func = function(self, layer)
			if ellejokers.mod_data.config.pixel_shader.enabled then
				self.children.center:draw_shader('elle_pixelated_fallback', nil, self.ARGS.send_to_shader)
				if self.children.front and not self:should_hide_front() then
					self.children.front:draw_shader('elle_pixelated_fallback', nil, self.ARGS.send_to_shader)
				end
			end
		end,
		conditions = { vortex = false, facing = 'front' }
	}

	SMODS.DrawStep {
    key = 'elle_pixelated_floating_sprite',
    order = 60,
    func = function(self)
        if ellejokers.mod_data.config.pixel_shader.enabled and self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            if type(self.config.center.soul_pos.draw) ~= 'function' and self.children.floating_sprite then
                self.children.floating_sprite:draw_shader('elle_pixelated_fallback',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children.floating_sprite:draw_shader('elle_pixelated_fallback', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
end

ellejokers.mod_data.menu_cards = function()
    return {
		-- Elle on title card
		{
			key = "j_elle_elle",
			no_edition = true,
			
		},
		
		-- Let it have a description
		-- ty @somethingcom515 for this lol
		func = function()
			for k, v in pairs(G.title_top.cards) do
				if v.config.center.key == 'j_elle_elle' then
					v.no_ui = false
					v.bypass_lock = true
				end
			end
		end
	}
end

