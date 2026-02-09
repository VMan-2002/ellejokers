local sarah = SMODS.Joker {
	key = 'sarah',
	blueprint_compat = true,
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 4, y = 2 },
	cost = 7
}

sarah.calculate = function(self, card, context)
	if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
		return {
			message = localize('k_again_ex'),
			repetitions = 1,
			card = card
		}
	end
end

sarah.slime_upgrade = {
	card = "j_elle_mint",
	can_use = function(self, card) return false end,
	loc_vars = function(self, card) return { } end
}