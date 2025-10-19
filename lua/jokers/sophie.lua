local sophie = SMODS.Joker {
	key = 'sophie',
	loc_txt = {
		name = 'Sophie',
		text = {
			"{C:mult}+#1#{} Mult per excess",
			"{C:attention}Blind Size{} Scored at",
			"end of round, resets",
			"when {C:attention}Boss Blind{} is defeated",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			caption.."Could do no wrong...?"
		},
		unlock = {
			"Reach {C:attention}10x",
			"Blind Score"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { mult_mod = 2, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	cost = 6,
	unlocked = false,
	blueprint_compat = true,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then return G.GAME.chips/G.GAME.blind.chips >= to_big(10) end
	end
}

sophie.calculate = function(self, card, context)
	if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
		-- Reset on boss blind
		if (G.GAME.blind.boss and to_big(card.ability.extra.mult) > to_big(0)) then
			card.ability.extra.mult = 0
			SMODS.calculate_effect({ message = "Reset!" }, card)
		end
		
		-- Add the mult stuff
		if math.floor(G.GAME.chips / G.GAME.blind.chips) ~= 1 then
			local _mult = (math.floor(G.GAME.chips / G.GAME.blind.chips)-1) * card.ability.extra.mult_mod
			
			card.ability.extra.mult = card.ability.extra.mult + _mult
			
			card:juice_up(.1,.1)
			
			return {
				message = localize { type = 'variable', key = 'a_mult', vars = { _mult } }
			}
		end
	end
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
end

sophie.elle_upgrade = {
	card = "j_elle_fallen",
	values = function(self, card) return { mult = to_big(card.ability.extra.mult)/to_big(2) } end,
	can_use = function(self, card) return to_big(card.ability.extra.mult) >= to_big(50) end
}