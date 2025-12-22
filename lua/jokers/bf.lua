local bf = SMODS.Joker {
	key = 'bf',
	config = { extra = { xmult = 1, miss = 0.1, win = 3, loss = 0.5, min = 1, attempted = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.win, card.ability.extra.miss, card.ability.extra.xmult, card.ability.extra.attempted and "Inactive" or "Active" } }
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
		card.ability.extra.xmult = 1
		return {
			message = "RETRY?"
		}
	end
end

bf.slime_active = {
	calculate = function(self, card)
		if photochadfunkin and photochadfunkin.options then
			photochadfunkin.jokerEdition = card.edition and card.edition.type
			photochadfunkin.multBase = card.ability.extra.win
			photochadfunkin.multPerMiss = card.ability.extra.miss
			photochadfunkin.multMinimum = card.ability.extra.min
			photochadfunkin.multOnLoss = card.ability.extra.loss
			photochadfunkin.onWin = function(self)
				card.ability.extra.attempted = true
				card.ability.extra.xmult = math.max(self.multBase - (self.misses * self.multPerMiss), self.multMinimum)
			end
			photochadfunkin.onLose = function(self)
				card.ability.extra.attempted = true
				card.ability.extra.xmult = photochadfunkin.multOnLoss
			end
			return photochadfunkin:options(card)
		end
		--[[card.ability.extra.attempted = true
		
		local max_misses = ((card.ability.extra.win-1)*(1/card.ability.extra.miss))
		local misses = math.floor(pseudorandom("elle_bf")*max_misses+0.5)
		card.ability.extra.xmult = card.ability.extra.win - misses*card.ability.extra.miss]]
		
		SMODS.calculate_effect({ message_card = card,
			message = "Error!",
			--extra = { message = misses .." Misses" }
		}, card)
	end,
	can_use = function(self, card) return not card.ability.extra.attempted end,
	should_close = function(self, card) return true end
}