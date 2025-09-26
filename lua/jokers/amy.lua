SMODS.Joker {
	key = 'amy',
	loc_txt = {
		name = 'Amy',
		text = {
			"idk",
			caption..'"Let\'s have some fun~"'
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.oc() end,
	config = { extra = { odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { elle_prob_loc(card, card.ability.extra.odds), card.ability.extra.odds } }
	end,
	rarity = 4,
	atlas = 'legendary',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	cost = 20,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	unlocked = false
}