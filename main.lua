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

--		[[ File List ]]
local files = {
	"skins",
	"consumables",
	"misc",
	"http",
	"challenges"
}

--		[[ Joker List ]]
-- Comment out jokers you want to disable
local jokers = {
			-- Canon OCs
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
	"41",
	
			-- Jess's Minecraft Idea
	"waterbucketrelease/cobble_gen",
	"waterbucketrelease/water_bucket",
	"waterbucketrelease/lava_bucket",
	"waterbucketrelease/cobblestone",
	"waterbucketrelease/obsidian",
	
			-- Other stuff
	"drago",
	"vivian",
	"carpet",
	"polyamory",
	"bf",
	"nitro",
	"eraser",
	"suggestion",
	
			-- Legendaries
	"twy",
	"elle"
}

--		[[ Atlases ]]
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
	key = "tag",
	path = "tags.png",
	px = 34,
	py = 34
}

--		[[ Sounds ]]
SMODS.Sound {
	key = "carpet",
	path = "carpet.ogg"
}
SMODS.Sound {
	key = "fizz",
	path = "fizz.ogg"
}

--		[[ Config / Optional Features ]]
-- Optional Features
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true, quantum_enhancements = true }
end

-- Text Colours
loc_colour('red')
G.ARGS.LOC_COLOURS['elle'] = HEX('FF53A9')

-- Text Prefix Shortcuts
caption = '{C:elle,s:0.7,E:1}'

-- Badges
elle_badges = {
	["mall"] = {
		text = "The Mall",
		colour = HEX('b7a2fd')
	},
	["oc"] = {
		text = "ellestuff.",
		colour = HEX('ff53a9')
	},
	["friends"] = {
		text = "Friends of Elle",
		colour = HEX('ff53a9')
	},
	["mc"] = {
		text = "Minecraft",
		colour = HEX('ff005f')
	},
}

-- Cryptid/Talisman Compatibility functions
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

-- Add spearmint animations
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

for i, v in ipairs(files) do
	assert(SMODS.load_file("lua/"..v..".lua"))()
end

for i, v in ipairs(jokers) do
	assert(SMODS.load_file("lua/jokers/"..v..".lua"))()
end
