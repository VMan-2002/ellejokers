local j = SMODS.Joker {
	key = 'p41',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.mall) end end,
	config = { extra = { target = nil } },
	loc_vars = function(self, info_queue, card) return { vars = { "#" } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 4 },
	soul_pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = false
}

j.calculate = function(self, card, context)
	if context.before then
		local hasAce = false
		local has4 = false
		for _, v in pairs(context.full_hand) do
			has4 = has4 or v:get_id() == 4
			hasAce = hasAce or v:get_id() == 14
		end
		
		if (hasAce and has4) then
			card.ability.extra.target = pseudorandom_element(G.jokers.cards, "elle_41", {in_pool = function(v, args) return v ~= card end})
		end
	end
	if context.retrigger_joker_check and card.ability.extra.target and context.other_card == card.ability.extra.target then
		card.ability.extra.target = nil
		return {
			message = "Again!",
			repetitions = 1,
			card = card
		}
	end
end