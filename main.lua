--		[[ To-Do List ]]
--	- New Joker art
--		- Chloe
--		- "Chloe"
--		- Furry
--		- Drago
--	- More Jokers????
--		- pls don't scope creep i swear to god-
--		- amy
--			- https://discord.com/channels/@me/1166439434544218213/1370339519068635247
--	- Fix Bugs
--		- MoreFluff
--			- Custom Colour card crashes game on round end
--	- Make Jess an optional toggle


--		[[ File List ]]
local files = {
	"jokers.lua",
	"challenges.lua",
	"skins.lua",
	"misc.lua"
}


--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
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


--		[[ Config / Optional Features ]]
-- Optional Features
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true }
end

-- Text Colours
loc_colour('red')
G.ARGS.LOC_COLOURS['elle'] = HEX('FF53A9')
G.ARGS.LOC_COLOURS['e_possessed'] = HEX('B7A2FD')

-- Text Prefix Shortcuts
caption = '{C:elle,s:0.7,E:1}'
caption_p = '{C:e_possessed,s:0.7,E:1}'


--		[[ Parasite Upgrades ]]
-- Jokers that can be upgraded by the Parasite consumable. [vars] table lets values carry over.
elle_parasite_upgrades = {
	["j_joker"] = { upgrade = "j_elle_parajoker" },
	["j_elle_chloe"] = { upgrade = "j_elle_furry" },
	["j_elle_furry"] = { upgrade = "j_elle_furry2", vars = { ["mult"] = "mult" } },
	["j_elle_furry2"] = { upgrade = "j_elle_chesh" },
	["j_elle_drago"] = { upgrade = "j_elle_symbiosis" },
	["j_elle_marie"] = { upgrade = "j_elle_admin" },
	["j_lusty"] = { upgrade = "j_elle_polyamory" }
}

function upgrade_joker(joker, upgrades)
	local _c = joker
	local _j_key = _c.config.center.key
	local _upgrade = upgrades[_j_key]
	
	local _vars = {}
	if _upgrade.vars ~= nil then
		for i,v in pairs(_upgrade.vars) do
			_vars[i] = _c.ability.extra[v]
		end
	end
	
	if (_upgrade) ~= nil then transform_joker(joker, _upgrade.upgrade, _vars, false) end
end

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
			
			if Cryptid ~= nil then card:set_ability(G.P_CENTERS[joker], true, nil)
			else card:set_ability(joker) end
			card:set_cost()
			
			for i,v in pairs(vars) do
				card.ability.extra[i] = v
			end
			
			if not instant then card:flip() end
			return true
		end
	}))
end

-- Cryptid/Talisman Compatibility functions
function elle_prob(card,p_key,odds)
	return pseudorandom(p_key) < (cry_prob(card.ability.cry_prob, odds, card.ability.cry_rigged) or G.GAME.probabilities.normal) / odds
end

function elle_prob_loc(card,odds)
	return Cryptid and cry_prob(card.ability.cry_prob, odds, card.ability.cry_rigged) or G.GAME.probabilities.normal or 1
end

to_big = to_big or function(x) return x end
-- Use button on jokers, copied and modified from the lobcorp mod
local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local t = use_and_sell_buttonsref(card)
    if t and t.nodes[1] and t.nodes[1].nodes[2] and card.config.center.elle_active and type(card.config.center.elle_active) == "table" then
        table.insert(t.nodes[1].nodes[2].nodes, 
            {n=G.UIT.C, config={align = "cr"}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'elle_active_ability', func = 'elle_can_use_active'}, nodes={
                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                    {n=G.UIT.T, config={text = card.config.center.elle_active.name and card.config.center.elle_active:name(card) or localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                }}
            }}
        )
    end
    return t
end

G.FUNCS.elle_can_use_active = function(e)
    local card = e.config.ref_table
    local can_use = 
    not (not skip_check and ((G.play and #G.play.cards > 0) or
    (G.CONTROLLER.locked) or
    (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))) and
    G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT and
    card.area == G.jokers and not card.debuff and
    (not card.config.center.elle_active.can_use or card.config.center.elle_active:can_use(card))
    if can_use then 
        e.config.colour = G.C.RED
        e.config.button = 'elle_active_ability'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.elle_active_ability = function(e, mute, nosave)
    local card = e.config.ref_table

    G.E_MANAGER:add_event(Event({func = function()
        e.disable_button = nil
        e.config.button = 'elle_active_ability'
    return true end }))

	if card.children.use_button then card.children.use_button:remove(); card.children.use_button = nil end
	if card.children.sell_button then card.children.sell_button:remove(); card.children.sell_button = nil end
	
    card.config.center.elle_active:calculate(card)
	card.area:remove_from_highlighted(card)
	
	if (card.config.center.elle_active.should_close and not card.config.center.elle_active:should_close(card)) then card.area:add_to_highlighted(card) end
end

for i, v in ipairs(files) do
	assert(SMODS.load_file("lua/"..v))()
end