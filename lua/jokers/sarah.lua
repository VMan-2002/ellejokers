local sarah = SMODS.Joker {
	key = 'sarah',
	loc_txt = {
		name = 'Sarah',
		text = {
			"Played cards with",
			"{C:clubs}Club{} suit give",
			"{X:mult,C:white}X#1#{} Mult when scored",
			caption.."Keeping things working"
		}
	},
	blueprint_compat = true,
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult } } end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 11
}

sarah.calculate = function(self, card, context)
	if context.individual and not context.end_of_round and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
		return {
			x_mult = card.ability.extra.xmult,
			card = card
		}
	end
end