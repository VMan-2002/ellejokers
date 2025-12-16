local spearlamp = SMODS.Joker {
	key = 'spearlamp',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        info_queue[#info_queue+1] = G.P_CENTERS.m_elle_slime
		
		return { vars = { } }
	end,
	atlas = 'jokers',
	pos = { x = 5, y = 1 },
	rarity = 2,
	cost = 6
}

spearlamp.calculate = function(self, card, context)
	if context.check_enhancement and (context.other_card.config.center.key == "m_steel" or context.other_card.config.center.key == "m_elle_slime") then
		return{
			m_steel = true,
			m_elle_slime = true
		}
	end
end