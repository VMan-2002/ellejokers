local cassie = SMODS.Joker {
	key = 'cassie',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { mult_mod = 4, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 4 },
	cost = 5,
	blueprint_compat = true
}

cassie.calculate = function(self, card, context)
	if context.end_of_round and context.cardarea == G.jokers then
		card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		
		return {
			message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } },
			colour = G.C.MULT
		}
	end
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end
end