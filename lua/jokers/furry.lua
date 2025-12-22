local furry = SMODS.Joker {
	key = 'furry',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { mult_mod = 5, mult = 0, used = false, req = 10, count = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "elle_upgr_no_shop"}
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.used and "Inactive" or "Active" } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true
}

furry.calculate = function(self, card, context)
	if context.setting_blind then
		card.ability.extra.used = false
	end
	-- Mult stuff
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end
end

furry.slime_active = {
	calculate = function(self, card)
		local _card = G.hand.highlighted[1]
		
		local _texts = {"Hehe~", "Oops~"}
		
		local _txt = _texts[math.random(#_texts)].." (+"..card.ability.extra.mult_mod..")"
		
		card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up(.4,.4)
			_card:start_dissolve({HEX("F68100")}, nil, 1.6)
			SMODS.destroy_cards(_card)
		return true end }))
		
		card.ability.extra.used = true
		card.ability.extra.count = card.ability.extra.count + 1
		
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

furry.slime_upgrade = {
	card = "j_elle_cheshire",
	values = function(self, card) return {Xmult = 1+card.ability.extra.count*.1} end,
	can_use = function(self, card) return #SMODS.find_card("j_elle_sarah", false)>0 and #SMODS.find_card("j_elle_cassie", false)>0 end,
	calculate = function(self, card)
		local sarah = find_joker("j_elle_sarah")[1]
		
		if sarah then
			transform_joker(find_joker("j_elle_cassie")[1],"j_elle_cassie2")
			transform_joker(sarah,"j_elle_mint")
		end
	end,
	loc_vars = function(self, card) return { card.ability.extra.req, card.ability.extra.count } end
}