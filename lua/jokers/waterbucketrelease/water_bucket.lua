local bucket = SMODS.Joker {
	key = 'water_bucket',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mc) end end,
	config = { extra = { chips = 50 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 2, y = 2 },
	cost = 1,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}

bucket.calculate = function(self, card, context)
	if context.joker_main then
		return { chips = card.ability.extra.chips }
	end
end