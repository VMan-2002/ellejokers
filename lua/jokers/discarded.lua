SMODS.Joker {
	key = 'discarded',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { money = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 6, y = 3 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.discard and context.other_card.debuff then
			return {
				dollars = card.ability.extra.money,
				message_card = context.other_card
			}
		end
	end
}