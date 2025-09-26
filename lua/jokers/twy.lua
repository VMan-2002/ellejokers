local twy = SMODS.Joker {
	key = 'twy',
	loc_txt = {
		name = 'TwyLight',
		text = {
			"At end of round,",
			"{C:green}1 in 4{} chance to",
			"destroy all cards held",
			"in hand and add {C:negative}Negative{}",
			"to a random joker",
			caption.."99... 100! This is too many tails~,,",
			"{C:inactive,s:0.7}Character belongs to",
			"{C:inactive,s:0.7}@twylightstar.bsky.social"
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.friends() end,
	config = { extra = { xmult_mod = 0.2, xmult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 4,
	atlas = 'legendary',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	cost = 20,
	unlocked = false
}

twy.calculate = function(self, card, context)
	if context.destroying_card and next(context.poker_hands['Straight']) and not context.blueprint then
		if context.cardarea == G.play then
			local _card = context.destroying_card
			
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				card:juice_up(.4,.4)
				_card:start_dissolve({HEX("FFAE36")}, nil, 1.6)
			return true end }))
			return {
				message_card = card,
				remove = true,
				message = "+X"..card.ability.extra.xmult_mod,
				colour = G.C.MULT
			}
		end
		
	end
	
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				Xmult_mod = card.ability.extra.xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
			}
		end
	end
end
