SMODS.Joker {
	key = 'marie',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	blueprint_compat = true,
	config = { extra = { cost = 5, cost_mod = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_elle_slime
		return { vars = { card.ability.extra.cost, card.ability.extra.cost_mod } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 6, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 7
}

local function get_marie_cost()
	local cost = nil
	local marie = nil
	for i, v in ipairs(SMODS.find_card("j_elle_marie")) do
		if not cost or cost > v.ability.extra.cost then
			cost = v.ability.extra.cost
			marie = v
		end
	end

	return cost, marie
end

local slime_upgrade = {
	card = "m_elle_slime",
	can_use = function(self, card) return (G.GAME.dollars - G.GAME.bankrupt_at) >= get_marie_cost() end,
	loc_vars = function(self, card)
		local cost, marie = get_marie_cost()
		return { cost, marie.ability.extra.cost_mod }
	end,
	loc_key = "elle_marie_upgrade",
	calculate = function(self, card)
		local cost, marie = get_marie_cost()
		ease_dollars(-cost)
		marie.ability.extra.cost = cost + marie.ability.extra.cost_mod
		
		SMODS.calculate_effect({ message_card = marie,
			message = localize("k_upgrade_ex")
		}, card)
	end
}

local slime_upgrade_hook = slimeutils.card_get_upgrade
function slimeutils.card_get_upgrade(card)
	if #SMODS.find_card("j_elle_marie")>0 and card.area == G.hand and card.config.center.key == "c_base" then
		return slime_upgrade
	end

	return slime_upgrade_hook(card)
end