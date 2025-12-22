local obsidian = SMODS.Joker {
	key = 'obsidian',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mc) end end,
	config = { extra = { xmult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 3 },
	cost = 10,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}

obsidian.calculate = function(self, card, context)
	if context.joker_main then
		return { Xmult = card.ability.extra.xmult }
	end
end