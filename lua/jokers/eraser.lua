local eraser = SMODS.Joker {
	key = 'eraser',
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.used and "Used" or "Available" } } end,
	config = { extra = { used = false } },
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 6, y = 0 },
	cost = 11
}


eraser.elle_active = {
	calculate = function(self, card)
		local target = (
			G.shop_jokers and #G.shop_jokers.highlighted == 1 and G.shop_jokers.highlighted[1] or
			G.shop_vouchers and #G.shop_vouchers.highlighted == 1 and G.shop_vouchers.highlighted[1] or
			G.shop_booster and #G.shop_booster.highlighted == 1 and G.shop_booster.highlighted[1] or
			G.pack_cards and #G.pack_cards.highlighted == 1 and G.pack_cards.highlighted[1])
			
		G.GAME.banned_keys[target.config.center_key] = true
		
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up(.4,.4)
			target:start_dissolve({HEX("FE7B76")}, nil, 1.6)
		return true end }))
		
		SMODS.calculate_effect({ message_card = card,
			remove = true,
			message = "Banned",
			colour = G.C.RED
		}, card)
		
		card.ability.extra.used = true
	end,
	
	can_use = function(self, card)
		local target = (
			G.shop_jokers and #G.shop_jokers.highlighted == 1 and G.shop_jokers.highlighted[1] or
			G.shop_vouchers and #G.shop_vouchers.highlighted == 1 and G.shop_vouchers.highlighted[1] or
			G.shop_booster and #G.shop_booster.highlighted == 1 and G.shop_booster.highlighted[1] or
			G.pack_cards and #G.pack_cards.highlighted == 1 and G.pack_cards.highlighted[1] or nil)
		
		return (
			(G.shop_jokers and #G.shop_jokers.highlighted or 0) +
			(G.shop_vouchers and #G.shop_vouchers.highlighted or 0) +
			(G.shop_booster and #G.shop_booster.highlighted or 0) +
			(G.pack_cards and #G.pack_cards.highlighted or 0)) == 1 and not card.ability.extra.used and not G.GAME.banned_keys[target.config.center_key]
	end,
	
	should_close = function(self, card) return true end
}