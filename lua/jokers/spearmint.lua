local spearmint = SMODS.Joker {
	key = 'spearmint',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 3,
	atlas = 'animated',
	pos = { x = 0, y = 0 },
	cost = 9,
	in_pool = function(self) return false end,
	no_doe = true
}