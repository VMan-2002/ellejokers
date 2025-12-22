nitro = SMODS.Joker {
	key = 'nitro',
	config = { extra = { mult = 0, mult_mod = 15, cost = 10, used = false } },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.cost-0.01, card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.used and "Bought" or "Available" } } end,
	atlas = 'jokers',
	pos = { x = 4, y = 3 },
	rarity = 2,
	cost = 5
}

nitro.calculate = function(self, card, context)
	-- Get fucked lol
	if context.end_of_round and not card.ability.extra.used and to_big(card.ability.extra.mult) > to_big(0) then
		card.ability.extra.mult = 0
		return { message = "Reset!" }
	end
	if context.setting_blind then
		card.ability.extra.used = false
		return { message = "Needs Renewal!" }
	end
	-- Mult stuff
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
end

nitro.slime_active = {
	calculate = function(self, card)
		ease_dollars(-card.ability.extra.cost)
		card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		card.ability.extra.used = true
		
		SMODS.calculate_effect({
			message = "-$"..card.ability.extra.cost-0.01,
			colour = G.C.MONEY,
			extra = {
				message = "Renewed (+"..card.ability.extra.mult_mod..")",
				colour = G.C.RED
			}
		}, card)
	end,
	can_use = function(self, card) return to_big(G.GAME.dollars) >= to_big(card.ability.extra.cost) and not card.ability.extra.used end,
	should_close = function(self, card) return true end
}