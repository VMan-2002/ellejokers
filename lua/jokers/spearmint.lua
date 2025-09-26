local spearmint = SMODS.Joker {
	key = 'spearmint',
	loc_txt = {
		name = 'Spearmint',
		text = {
			"idk",
			caption..'"Can we wander for a spell?"'
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 3,
	atlas = 'animated',
	pos = { x = 0, y = 0 },
	in_pool = function(self) return false end,
	cost = 9
}