SMODS.Joker {
	key = 'diamond_pickaxe',
	config = { extra = { mult = 4 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "eternal"}
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 4, y = 5 },
	soul_pos = { x = 5, y = 5 },
	cost = 11,
	blueprint_compat = false,
	add_to_deck = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.I.CARD) do if v.set_cost then v:set_cost() end end
		return true end}))
	end,
	remove_from_deck = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.I.CARD) do if v.set_cost then v:set_cost() end end
		return true end}))
	end
}


local csc_hook = Card.can_sell_card
function Card:can_sell_card(context, ...)
	local csc = csc_hook(self, context, ...)
	
	if (SMODS.is_eternal(self, {from_sell = true}) and #SMODS.find_card("j_elle_diamond_pickaxe", false)>0) then
		return to_big(G.GAME.dollars) >= to_big(-self.sell_cost)
	end
	
	return csc
end

local sc_ref = Card.set_cost
function Card:set_cost(...)
	sc_ref(self, ...)
	
	if #SMODS.find_card("j_elle_diamond_pickaxe", false)>0 then
		self.sell_cost = SMODS.is_eternal(self, {from_sell = true}) and self.sell_cost * -(SMODS.find_card("j_elle_diamond_pickaxe", false)[1].ability.extra.mult) or self.sell_cost
	end
end