if not next(SMODS.find_mod("Blindside")) then return end -- Only continue if playing with Blindside
print("ellejokers blindside time!!")

SMODS.Atlas{
	key = "jokerenemy",
	path = "blindside/jokers.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21
}

BLINDSIDE.Joker{
	key = 'suggestion',
	atlas = 'elle_jokerenemy',
	pos = {x=0, y=0},
	boss_colour = HEX('dc6eb3'),
	mult = 12,
	base_dollars = 6,
	boss = {min = 3},
	active = true,
	calculate = function(self, blind, context)
		if context.before and not blind.disabled then
			--[[for i,v in ipairs(G.hand.cards) do
				v:set_ability(G.P_CENTERS.m_bld_queen, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				}))
			end
			
			if #G.hand.cards>0 then
				return {
					message = localize("elle_suggestion"),
					colour = G.ARGS.LOC_COLOURS.elle
				}
			end]]
		end
	end
}

BLINDSIDE.Joker{
	key = 'chloe',
	atlas = 'elle_jokerenemy',
	pos = {x=0, y=1},
	boss_colour = HEX('f68100'),
	mult = 12,
	base_dollars = 6,
	boss = {min = 1},
	active = true,
	calculate = function(self, blind, context)
		if context.discard and not blind.disabled then
			BLINDSIDE.chipsmodify(0, 20, 0, 0)
			
			-- Update chips after discarding all blinds
			if context.other_card == context.full_hand[#context.full_hand] then
				G.E_MANAGER:add_event(Event({func = function()
					BLINDSIDE.chipsupdate() return true end}))
			end
		end
	end
}