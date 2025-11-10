local mint = SMODS.Joker {
	key = 'mint',
	blueprint_compat = true,
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult } } end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 5, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 9,
	in_pool = function(self) return false end,
	no_doe = true
	
}

mint.calculate = function(self, card, context)
	if context.individual and not context.end_of_round and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
		return {
			x_mult = card.ability.extra.xmult,
			card = card
		}
	end
end