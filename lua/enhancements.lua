-- Slime Enhancement
SMODS.Enhancement {
	key = 'slime',
	atlas = 'enhancers',
	pos = { x = 0, y = 0 },
	config = { extra = { odds = 3, retriggers = 2 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'elle_slime_card')
		return { vars = { numerator, denominator, card.ability.extra.retriggers } }
	end,
	calculate = function(self, card, context)
		if context.repetition and SMODS.pseudorandom_probability(card, 'elle_slime_card', 1, card.ability.extra.odds) then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra.retriggers
			}
		end
	end
}

-- Jess Enhancement
SMODS.Enhancement {
	key = 'jess',
	atlas = 'enhancers',
	pos = { x = 1, y = 0 },
	config = { extra = { }, bonus = 10 },
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.bonus } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			local retriggers = 0
			for i,v in ipairs(G.play.cards) do
				if (v ~= card and SMODS.has_enhancement(v, "m_elle_jess")) then retriggers = retriggers + 1 end
			end
			
			if SMODS.find_card("j_elle_jess")[1] then
				for i,v in ipairs(G.hand.cards) do
					if SMODS.has_enhancement(v, "m_elle_jess") then retriggers = retriggers + 1 end
				end
			end
			
			return {
				message = localize('k_again_ex'),
				repetitions = retriggers
			}
		end
	end
}