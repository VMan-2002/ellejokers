local carpet = SMODS.Joker {
	key = 'carpet',
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.toby() end,
	config = { extra = { xmult_mod = 0.25, xmult = 1 } },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } } end,
	rarity = 2,
	atlas = 'animated',
	pos = { x = 0, y = 2 },
	blueprint_compat = true,
	cost = 9
}

carpet.calculate = function(self, card, context)
	if context.joker_main then
		if next(context.poker_hands['Full House']) and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			return {
				message = "Carpet (+X"..(card.ability.extra.xmult_mod)..")",
				sound = "elle_carpet",
				colour = G.C.MULT,
				extra = {
					Xmult_mod = card.ability.extra.xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
				}
			}
		end
		if card.ability.extra.xmult ~= 1 then
			return {
				Xmult_mod = card.ability.extra.xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
			}
		end
	end
end
