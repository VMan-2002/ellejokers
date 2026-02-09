local ourple = SMODS.Joker {
	key = 'ourple',
	config = { extra = { cards = 2, xmult = 1, xmult_mod = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 1, y = 4 },
	cost = 8
}

ourple.calculate = function(self, card, context)
	if context.before and next(context.poker_hands['Flush']) and #G.hand.cards>0 then
		local spades_check = 0
		for i,v in ipairs(context.scoring_hand) do
			if (v:is_suit('Spades')) then spades_check = spades_check+1 end
		end
		
		if spades_check >= SMODS.four_fingers('Flush') then
			local c = math.min(card.ability.extra.cards,#G.hand.cards)
			for i=1,c do SMODS.destroy_cards(pseudorandom_element(G.hand.cards, "elle_ourple_kill")) end
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod * c
			
			SMODS.calculate_effect({ message_card = card,
				remove = true,
				message = localize("elle_ourple_kill"),
				colour = G.C.PURPLE
			}, card)
		end
	end
	
	if context.joker_main and card.ability.extra.xmult ~= 0 then
		return { Xmult = card.ability.extra.xmult }
	end
end