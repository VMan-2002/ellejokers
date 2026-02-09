local feri = SMODS.Joker {
	key = 'feri',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.friends) end end,
	config = { extra = { mult = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {
			set = "Other", key = "elle_crossover", specific_vars = {"That Azazel Fire","@thatazazelfire.bsky.social"},
			slime_desc_icon = { atlas = "elle_cornericons", pos = {x=0,y=0} }
		}
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 6, y = 3 },
	cost = 6,
	blueprint_compat = true
}

feri.calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
		context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
			card.ability.extra.mult
		return {
			message = localize('k_upgrade_ex'),
			colour = G.C.MULT
		}
	end
end