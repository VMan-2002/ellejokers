local obsidian = SMODS.Joker {
	key = 'obsidian',
	loc_txt = {
		name = 'Obsidian',
		text = {
			"{X:mult,C:white}X#1#{} Mult"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mc() end,
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