local drago = SMODS.Joker {
	key = 'drago',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.friends) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = false
}

drago.calculate = function(self, card, context)
	if context.debuff_card and SMODS.has_enhancement(context.debuff_card, 'm_wild') then
		return { prevent_debuff = true }
	end
end