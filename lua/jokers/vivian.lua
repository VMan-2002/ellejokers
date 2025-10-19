local vivian = SMODS.Joker {
	key = 'vivian',
	loc_txt = {
		name = 'Vivian',
		text = {
			"{C:green}#1# in #2#{} chance to",
			"give {C:attention}scoring hand",
			"random {C:enhanced}Enhancements"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.friends() end,
	loc_vars = function(self, info_queue, card)
		return { vars = { elle_prob_loc(card,card.ability.extra.odds), card.ability.extra.odds } }
	end,
	config = { extra = { odds = 8 } },
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 1 },
	cost = 7
}

vivian.calculate = function(self, card, context)
	if context.before and context.cardarea == G.jokers and elle_prob(card, 'elle_vivian', card.ability.extra.odds) then
		for k, v in ipairs(context.scoring_hand) do
			local ench = SMODS.poll_enhancement({
				key = "elle_vivian_card",
				guaranteed = true
			})
			
			v:set_ability(G.P_CENTERS[ench], nil, true)
		end
		
		return {}
	end
end