local sarah = SMODS.Joker {
	key = 'sarah',
	blueprint_compat = true,
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { odds = 2, criteria = 25, upgr = 0 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'elle_sarah')
		return { vars = { numerator, denominator } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 4, y = 2 },
	in_pool = function(self) return false end,
	cost = 7
}

sarah.calculate = function(self, card, context)
	if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Clubs") and SMODS.pseudorandom_probability(card, 'elle_sarah', 1, card.ability.extra.odds) then
		card.ability.extra.upgr = card.ability.extra.upgr + 1
		return {
			message = localize('k_again_ex'),
			repetitions = 1,
			card = card
		}
	end
end

sarah.elle_upgrade = {
	card = "j_elle_mint",
	can_use = function(self, card) return card.ability.extra.upgr >= card.ability.extra.criteria end,
	loc_vars = function(self, card) return { card.ability.extra.criteria, card.ability.extra.upgr } end
}