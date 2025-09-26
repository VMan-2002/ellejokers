local lucidity = SMODS.Joker {
	key = 'lucidity',
	loc_txt = {
		name = 'Lucidity',
		text = {
			"Shows the next {C:attention}#1#",
			"cards in the deck",
			"{C:green}#2# in #3#{} chance to",
			"give {C:attention}all{} scoring cards",
			"random {C:enhanced}enhancements"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.oc() end,
	loc_vars = function(self, info_queue, card)
		local list = {}
		if card.ability.extra.held and #G.deck.cards > 0 then
			local topCards = CardArea(0,0,4+(math.min(card.ability.extra.cards,#G.deck.cards)*.2),3,{type = 'title', card_limit = 3})
			for i = 1, card.ability.extra.cards do
				if (#G.deck.cards < i) then break end
				
				local _c = copy_card(G.deck.cards[#G.deck.cards-i+1], nil, nil, G.playing_card)
				_c.T.w = G.CARD_W*.75
				_c.T.h = G.CARD_H*.75
				topCards:emplace(_c)
				_c.facing='front'
			end
			
			list = {{
				n = G.UIT.O,
				config = { object = topCards }
			}}
		end
		
		return { vars = { card.ability.extra.cards, elle_prob_loc(card,card.ability.extra.odds), card.ability.extra.odds }, main_end = list }
	end,
	config = { extra = { cards = 3, odds = 8, held = false } },
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 0, y = 3 },
	soul_pos = { x = 5, y = 3 },
	cost = 7
}

lucidity.calculate = function(self, card, context)
	if context.before and context.cardarea == G.jokers and elle_prob(card, 'elle_lucidity', card.ability.extra.odds) then
		for k, v in ipairs(context.scoring_hand) do
			local ench = SMODS.poll_enhancement({
				key = "elle_lucidity_card",
				guaranteed = true
			})
			
			print(ench)
			
			v:set_ability(G.P_CENTERS[ench], nil, true)
		end
		return {}
	end
end

lucidity.add_to_deck = function(self, card, from_debuff)
	card.ability.extra.held = true
end

lucidity.remove_to_deck = function(self, card, from_debuff)
	card.ability.extra.held = false
end