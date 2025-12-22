local fallen = SMODS.Joker {
	key = 'fallen',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { xmult_mod = 0.4, charges = 0, active = false } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}
		return { vars = { card.ability.extra.xmult_mod, 1+(card.ability.extra.xmult_mod*card.ability.extra.charges) } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	cost = 6,
	unlocked = false,
	blueprint_compat = true,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then return G.GAME.chips/G.GAME.blind.chips >= to_big(10) end
	end,
	in_pool = function(self) return false end,
	no_doe = true
}

fallen.calculate = function(self, card, context)
	-- Add the mult stuff
	if context.after and SMODS.last_hand_oneshot and not context.blueprint then
		G.E_MANAGER:add_event(Event({func = function()
			card.ability.extra.charges = card.ability.extra.charges+1
			card:juice_up(.1,.1)
			SMODS.calculate_effect({ message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_mod } } }, card)
		return true end }))
	end
	
	if context.joker_main and card.ability.extra.active then
		local _xmult = 1+(card.ability.extra.xmult_mod * card.ability.extra.charges)
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up(.1,.1)
			card.ability.extra.charges = 0
			card.ability.extra.active = false
		return true end }))
		return { xmult = _xmult }
	end
end

fallen.slime_active = {
	calculate = function(self, card)
		card.ability.extra.active = true
		
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up(.4,.4)
			SMODS.calculate_effect({ message = localize("elle_joker_activate") }, card)
			juice_card_until(card, function() return not G.RESET_JIGGLES and card.ability.extra.active end, true)
		return true end }))
	end,
	can_use = function(self, card) return card.ability.extra.charges > 0 and G.STATE == G.STATES.SELECTING_HAND and not card.ability.extra.active end,
	should_close = function(self, card) return true end
}
