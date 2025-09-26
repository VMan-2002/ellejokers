local spearlamp = SMODS.Joker {
	key = 'spearlamp',
	loc_txt = {
		name = 'Spearlamp',
		text = {
			"{C:enhanced}Steel{} and {C:enhanced}Slime{} Cards",
			"{C:attention}share effects",
			caption..'This was Chloe\'s Idea...'
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
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
	if context.check_enhancement then
		if context.other_card.config.center.key == "m_steel" or context.other_card.config.center.key == "m_elle_slime" then
			return{
				m_steel = true,
				m_elle_slime = true
			}
		end
	end
end

-- Set the info queues of steel and slime cards if this joker is equipped
local lv_ref = Card.loc_vars
function Card:loc_vars(info_queue,card)
	local lv = lv_ref(self,info_queue,card)
	
	print("test")
	print("enhancement: "..self.config.center_key)
	print("lamp count: "..#SMODS.find_card("j_elle_spearlamp", false))
	
if (#SMODS.find_card("j_elle_spearlamp", false)>0) then
	if (self.config.center_key == "m_steel") then info_queue[#info_queue+1] = G.P_CENTERS.m_elle_slime end
	if (self.config.center_key == "m_elle_slime") then info_queue[#info_queue+1] = G.P_CENTERS.m_steel end
end
	
	return lv
end