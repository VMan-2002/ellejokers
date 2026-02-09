local bucket = SMODS.Joker {
	key = 'water_bucket',
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_elle_cobblestone
		
		return { vars = { card.ability.extra.chips } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 2, y = 2 },
	cost = 1,
	no_collection = true,
	blueprint_compat = false,
	in_pool = function(self) return false end,
	no_doe = true
}