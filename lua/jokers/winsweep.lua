local winsweep = SMODS.Joker {
	key = 'winsweep',
	loc_txt = {
		name = 'Winsweep',
		text = {
			"This joker gains {X:mult,C:white}X#1#{} Mult",
			"for each consecutive",
			"{C:attention}First Hand{} win",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
			" ",
			caption.."Winsweep never loses!",
			"{C:inactive,s:0.7}Character from",
			"{C:inactive,s:0.7}Content SMP"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mc() end,
	config = { extra = { xmult = 1, xmult_mod = 0.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	cost = 8
}

winsweep.calculate = function(self, card, context)
	if context.end_of_round and context.cardarea == G.jokers then
		if (G.GAME.current_round.hands_played == 1) then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			
			card:juice_up(.1,.1)
			return {
				message = "Win! (+X"..card.ability.extra.xmult_mod..")"
			}
		elseif (card.ability.extra.xmult ~= 1) then
			card.ability.extra.xmult = 1
			
			card:juice_up(.1,.1)
			return {
				message = "Reset"
			}
		end
	end
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				xmult_mod = card.ability.extra.xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
			}
		end
	end
end
