local drago = SMODS.Joker {
	key = 'drago',
	loc_txt = {
		name = 'Drago',
		text = {
			"{C:attention}Wild Cards{} cannot",
			"get debuffed"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.friends() end,
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