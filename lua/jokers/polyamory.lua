local polyamory = SMODS.Joker {
	key = 'polyamory',
	loc_txt = {
		name = 'Polyamory',
		text = {
			"If played hand contains",
			"a {C:attention}Four of a Kind{},",
			"convert all scoring",
			"cards into {C:hearts}Hearts"
		}
	},
	config = { extra = { count = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.count } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	soul_pos = { x = 5, y = 3 },
	cost = 8,
	blueprint_compat = false
}

polyamory.calculate = function(self, card, context)
	if context.before and context.cardarea == G.jokers and next(context.poker_hands['Three of a Kind']) then
		local hearts = {}
		
		for k, v in ipairs(context.scoring_hand) do
			hearts[#hearts+1] = v
			if (v.base.value ~= hearts[1].base.value) then
				hearts = {}
				break
			end
		end
		
		if #hearts >= card.ability.extra.count then
			for k, v in ipairs(context.scoring_hand) do
				v:change_suit("Hearts")
				v:juice_up(0.3,0.4)
			end
			return {
				message = "<3",
				card = self
			}
		end
	end
end