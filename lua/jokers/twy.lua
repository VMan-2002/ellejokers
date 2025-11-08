local twy = SMODS.Joker {
	key = 'twy',
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.friends() end,
	config = { extra = { odds = 4 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'elle_twy')
		return { vars = { numerator, denominator } }
	end,
	rarity = 4,
	atlas = 'legendary',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	cost = 20,
	unlocked = false
}

twy.calculate = function(self, card, context)
	if context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, 'elle_twy', 1, card.ability.extra.odds) and #G.hand.cards > 0 then
		-- Find viable Jokers
		local candidates = {}
		for k, v in ipairs(G.jokers.cards) do
			local j = G.jokers.cards[k]
			if (j ~= card and not (j.edition and j.edition.key == "e_negative")) then candidates[#candidates+1] = j end
		end
		-- If there are non-negative jokers
		if #candidates > 0 then
			-- Destroy the cards in hand
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				for k, v in ipairs(G.hand.cards) do
					v:juice_up(.4,.4)
					v:start_dissolve({HEX("FFAE36")}, nil, 1.6)
				end
			return true end }))
			
			-- Set Joker to negative
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local j = pseudorandom_element(candidates, 'elle_twy_target')
				j:set_edition("e_negative", true)
				j:juice_up(.4,.4)
				card:juice_up(.4,.4)
			return true end }))
			
			return {
				remove = true,
				message = "Negative!",
				colour = G.C.DARK_EDITION
			}
		end
	end
end
