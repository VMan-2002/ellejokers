local mint = SMODS.Joker {
	key = 'mint',
	blueprint_compat = true,
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}
		return { vars = { card.ability.extra.xmult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 5, y = 2 },
	cost = 9,
	in_pool = function(self) return false end,
	unlocked = false
}

mint.calculate = function(self, card, context)
	if context.individual and not context.end_of_round and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
		return {
			x_mult = card.ability.extra.xmult,
			card = card
		}
	end
end