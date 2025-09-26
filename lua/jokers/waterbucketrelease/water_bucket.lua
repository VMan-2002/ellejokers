local bucket = SMODS.Joker {
	key = 'water_bucket',
	loc_txt = {
		name = 'Water Bucket',
		text = {
			"{C:chips}+#1#{} Chips",
			"When blind selected,",
			"if there is a single Joker",
			"between this and {C:attention}Lava Bucket{},",
			"turn it into {C:attention}Cobblestone",
			caption..'"Water Bucket, release!"'
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mc() end,
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