--		[[ To-Do List ]]
--	- New Joker art
--		- Chloe
--		- Furry
--		- Marie
--		- Twy
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
--				- LITERALLY JUST FNF
--				- Balatro SFX atonals similar to SCDM
--	- "The Microphone" boss blind
--		- Also FNF, like Boyfriend
--		- Plays a harder fnf song
--		- "Zoinks!" final boss blind
--			- 9k song, on par with (or literally just) Final Destination
--	- Fix Bugs
--		- MoreFluff
--			- Custom Colour card crashes game on round end
--	- Reword sophie/fallen angel joker effects		...again


--		[[ File List ]]
local files = {
	"j_buttons",
	"challenges",
	"skins",
	"misc",
	"http"
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
	py = 95,
}
SMODS.Atlas {
	key = "animated",
	path = "animated.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "legendary",
	path = "legendary.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "consumables",
	path = "consumables.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "enhancers",
	path = "enhancers.png",
	px = 71,
	py = 95,
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
	["mall"] =		function() return create_badge("The Mall", HEX('B7A2FD'), G.C.WHITE, 0.8 ) end,
	["oc"] =		function() return create_badge("ellestuff.", HEX('FF53A9'), G.C.WHITE, 0.8 ) end,
	["friends"] =	function() return create_badge("Friends of Elle", HEX('FF53A9'), G.C.WHITE, 0.8 ) end,
	["toby"] =		function() return create_badge("Toby Fox", HEX('FF0000'), G.C.WHITE, 0.8 ) end,
	["mc"] =		function() return create_badge("Minecraft", HEX('FF005F'), G.C.WHITE, 0.8 ) end
}

--		[[ Parasite Upgrades ]]
-- Deprecated, but good for referencing what upgrades need adding
elle_parasite_upgrades = {
	["j_elle_chloe"] = { upgrade = "j_elle_furry" },
	["j_elle_furry"] = { upgrade = "j_elle_cheshire" },
	["j_elle_sarah"] = { upgrade = "j_elle_mint" },
}

function transform_joker(card, joker, vars, instant)
	vars = vars or {}
	instant = instant or false
	
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = .1,
		func = function()
			if not instant then
				card:flip()
				delay(.5)
				play_sound('tarot1')
				card:juice_up(.8,.8)
			end
			
			-- Change joker
			if Cryptid ~= nil then card:set_ability(G.P_CENTERS[joker], true, nil)
			else card:set_ability(joker) end
			card:set_cost() -- Update cost
			
			-- Carry over values from old joker if u want
			for i,v in pairs(vars) do
				card.ability.extra[i] = v
			end
			card:set_cost() -- Update cost again bc of stuff like Cobblestone
			
			if not instant then card:flip() end
			return true
		end
	}))
end

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
