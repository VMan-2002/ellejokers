SMODS.Joker {
	key = 'marie',
	loc_txt = {
		name = 'Marie',
		text = {
			"{C:attention}Slime cards{} are",
			"guaranteed to trigger"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	blueprint_compat = true,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_elle_slime
		return { vars = { } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 6, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 7,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint_card and context.identifier == "elle_slime_card" then
			return { numerator = 3 }
		end
	end
}