local bea = SMODS.Joker {
	key = 'bea',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { mult = 2, poker_hand = "High Card" } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.poker_hand } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 1 },
	cost = 8,
	blueprint_compat = true
}

bea.calculate = function(self, card, context)
	-- Add the extra mult
	if context.individual and context.cardarea == G.play and context.scoring_name == card.ability.extra.poker_hand then
		context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
			card.ability.extra.mult
		return {
			message = localize('k_upgrade_ex'),
			colour = G.C.MULT
		}
	end
	
	-- Change shit ^w^
	if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
		local _poker_hands = get_hand_types(true)
		card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'elle_bea_hand')
		return { message = localize('k_reset') }
	end
end

bea.set_ability = function(self, card, initial, delay_sprites)
	local _poker_hands = get_hand_types(true)
	card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'elle_bea_hand')
end