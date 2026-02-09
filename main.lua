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
	calculate = {},
	reset_game_globals = {}
}

-- Create palettes
for k, v in ipairs(ellejokers.palettes) do
	v.image = love.graphics.newImage( love.image.newImageData(NFS.newFileData( SMODS.current_mod.path .. "assets/palettes/"..v.path) ) )
	local w,h = v.image:getDimensions()
	v.dims = {w,h}
end


--		[[ File List ]]
local lib = {
	"skins",
	"consumables",
	"misc",
	"http",
	"fnf/fnf_main",
	"challenges",
	"popup_shop",
	"enhancements",
	"blindside",
	"achievements",
	"config",
	--"blinds"
}

-- Only add LobCorp's blindexpander if the mod isn't present
lib[#lib+1] = next(SMODS.find_mod("LobotomyCorp")) and nil or "blindexpander"

--		[[ Joker List ]]
-- Using this to make sure the groups are in order
local joker_groups = {
	"mall",
	"crossovers",
	"waterbucketrelease",
	"misc",
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
		"cassie_stasis",
		--"not_cassie",
		"41",
		"prototypes"
	},

	-- Friends & Partners
	crossovers = {
		"drago",
		"vivian",
		"jess",
		"jessclip",
		"feri"
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
		"bf",
		"ourple",
		"nitro",
		"eraser",
		"suggestion",
		--"wordle"
	},

	-- Legendaries
	legendaries = {
		"twy",
		"elle"
	}
}

--local blinds = {"cassie_39"}

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
	select_music_track = function()
		return G.GAME.elle_popup_shop_open == "spamton"
	end,
	pitch = 1
}
--#endregion

--		[[ Config / Optional Features ]]
-- Optional Features
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true, quantum_enhancements = true }
end

-- Text Colours
loc_colour('red')
G.ARGS.LOC_COLOURS['elle'] = HEX('FF53A9')

-- Badges
elle_badges = {
	mall = {
		text = "The Mall",
		colour = HEX('b7a2fd')
	},
	oc = {
		text = "slimestuff.",
		colour = HEX('ff53a9')
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

-- Cryptid/Talisman Compatibility functions
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

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

SMODS.Shader {
	key = "pixelated",
	path = "pixelated.fs"
}

local w,h = love.graphics.getDimensions()
SMODS.ScreenShader {
	key = "pixelated",
	shader = "elle_pixelated", --modprefix is necessary, this now refers to the same shader defined above

	send_vars = function (self)
		local p = ellejokers.palettes[ellejokers.mod_data.config.pixel_shader.palette]
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

ellejokers.mod_data.menu_cards = function()
    return {
		key = "j_elle_elle",
		no_edition = true
	}
end

-- test drawstep,,
--[[SMODS.DrawStep {
	key = "elle_pixelated",
	order = 20,
	func = function(self, layer)
        self.children.center:draw_shader('elle_pixelated', nil, self.ARGS.send_to_shader)
		if self.children.front and not self:should_hide_front() then
			self.children.front:draw_shader('elle_pixelated', nil, self.ARGS.send_to_shader)
		end
	end,
    conditions = { vortex = false, facing = 'front' }
}]]