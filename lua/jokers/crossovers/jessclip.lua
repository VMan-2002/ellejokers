local jessclip = SMODS.Joker {
	key = 'jessclip',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.poly) end end,
	config = { extra = { count = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {
			set = "Other", key = "elle_crossover", specific_vars = {"Jess","@soup587.bsky.social"},
			slime_desc_icon = { atlas = "elle_cornericons", pos = {x=1,y=0} }
		}
		info_queue[#info_queue+1] = G.P_CENTERS.m_elle_jess
		return { vars = { card.ability.extra.count } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 2, y = 5 },
	cost = 6,
	blueprint_compat = false,
	enhancement_gate = 'm_elle_jess',
	slime_desc_icon = {
		atlas = "elle_cornericons",
		pos = {x=1,y=0}
	}
}