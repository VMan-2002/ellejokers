local bf = SMODS.Joker {
	key = 'bf',
	config = { extra = { xmult = 1, miss = 0.1, win = 3, attempted = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.win, card.ability.extra.miss, card.ability.extra.xmult, card.ability.extra.used and "Inactive" or "Active" } }
	end,
	rarity = 2,
	atlas = 'jokers',
	blueprint_compat = true,
	pos = { x = 5, y = 0 },
	cost = 7
}

bf.calculate = function(self, card, context)
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				Xmult = card.ability.extra.xmult
			}
		end
	end
	if context.end_of_round and card.ability.extra.attempted then
		card.ability.extra.attempted = false
		return {
			message = "RETRY?"
		}
	end
end

bf.elle_active = {
	calculate = function(self, card)
		card.ability.extra.attempted = true
		
		local max_misses = ((card.ability.extra.win-1)*(1/card.ability.extra.miss))
		local misses = math.floor(pseudorandom("elle_bf")*max_misses+0.5)
		card.ability.extra.xmult = card.ability.extra.win - misses*card.ability.extra.miss
		
		SMODS.calculate_effect({ message_card = card,
			message = "not coding allat",
			extra = { message = misses .." Misses" }
		}, card)
	end,
	can_use = function(self, card) return not card.ability.extra.attempted end,
	should_close = function(self, card) return true end
}