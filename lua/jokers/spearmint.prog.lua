local spearmint = SMODS.Joker {
	key = 'spearmintprog',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	display_size = { w = 71 , h = 81 },
	pixel_size = { w = 71 , h = 81 },
	rarity = 2,
	atlas = 'animated',
	pos = { x = 0, y = 1 },
	cost = 9
}

-- Temporarily empty, until I figure out how the fuck to implement that skill point system
spearmint.slime_active = {
	calculate = function(self, card)
		return {}
	end,
	can_use = function(self, card)
		return true
	end,
	should_close = function(self, card) return false end
}

spearmint.slime_upgrade = {
	card = "j_elle_spearmint",
	can_use = function(self, card) return to_big(G.GAME.dollars) >= to_big(20) end,
	calculate = function(self, card) ease_dollars(-20) end
}

