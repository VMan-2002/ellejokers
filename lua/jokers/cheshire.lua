local cheshire = SMODS.Joker {
	key = 'cheshire',
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { Xmult_mod = 0.1, Xmult = 1, used = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult, card.ability.extra.used and "Inactive" or "Active" } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 12,
	blueprint_compat = true,
	unlocked = false,
	parasite_bypass = true
}

cheshire.calculate = function(self, card, context)
	if context.before then
		card.ability.extra.used = false
	end
	-- XMult stuff
	if context.joker_main then
		if card.ability.extra.Xmult ~= 0 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
			}
		end
	end
end

cheshire.elle_active = {
	calculate = function(self, card)
		local _card = G.hand.highlighted[1]
		
		local _texts = {"*Stab*", "Pathetic.", "Oops~"}
		local _snd = 'slice1'
		
		local _txt = _texts[math.random(#_texts)].." (+X"..card.ability.extra.Xmult_mod..")"
		
		card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up(.4,.4)
			_card:shatter()
			play_sound(_snd, 1)
		return true end }))
		
		card.ability.extra.used = true
		
		SMODS.calculate_effect({ message_card = card,
			remove = true,
			message = _txt,
			colour = G.C.RED
		}, card)
	end,
	can_use = function(self, card)
		return #G.hand.highlighted == 1 and not card.ability.extra.used
	end,
	should_close = function(self, card) return true end
}

-- Example upgrade, do not seriously use :p
--[[
cheshire.elle_upgrade = {
	card = "j_elle_chloe",
	can_use = function(self, card) return to_big(G.GAME.dollars) >= to_big(20) end,
	calculate = function(self, card) ease_dollars(-20) end
}--]]