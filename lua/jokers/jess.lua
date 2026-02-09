local jess = SMODS.Joker {
	key = 'jess',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.poly) end end,
	config = { extra = { count = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_elle_jess
		return { vars = { card.ability.extra.count } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 5 },
	cost = 6,
	blueprint_compat = true
}

jess.calculate = function(self, card, context)
	if context.before and context.cardarea == G.jokers then
		for i=1,card.ability.extra.count do
			local c = pseudorandom_element(G.play.cards, "elle_jess_joker", {in_pool = function(v, args) return not SMODS.has_enhancement(v,"m_elle_jess") end})
			if (c) then c:set_ability(G.P_CENTERS.m_elle_jess, nil, true) end
		end
	end
end
