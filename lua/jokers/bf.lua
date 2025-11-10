local bf = SMODS.Joker {
	key = 'bf',
	loc_txt = {
		name = 'Boyfriend',
		text = {
			"{X:mult,C:white}X#1#{} Mult if you beat",
			"him in a {C:attention}Rap Battle",
			"{X:mult,C:white}X-#2#{} Mult per {C:attention}Miss",
			"Can be attempted",
			"once per round",
			"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
			"{C:inactive}(#4#)"
		}
	},
	config = { extra = { xmult = 1, miss = 0.1, win = 3, attempted = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.win, card.ability.extra.miss, card.ability.extra.xmult, card.ability.extra.used and "Inactive" or "Active" } }
	end,
	rarity = 2,
	atlas = 'jokers',
	blueprint_compat = true,
	pos = { x = 5, y = 0 },
	cost = 7,
	unlocked = false
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
		if photochadfunkin and photochadfunkin.options then
			photochadfunkin.jokerEdition = card.edition and card.edition.type
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