local chloe = SMODS.Joker {
	key = 'chloe',
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { chip_mod = 4, chips = 0, upgr_cost = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips, card.ability.extra.upgr_cost } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 5, y = 3 },
	cost = 5,
	blueprint_compat = true
}

chloe.calculate = function(self, card, context)
	if context.discard then
		card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
		return {
			message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_mod } },
			colour = G.C.CHIPS
		}
	end
	if context.end_of_round then
		card.ability.extra.chips = 0
	end
	if context.joker_main then
		if card.ability.extra.chips ~= 0 then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end
end