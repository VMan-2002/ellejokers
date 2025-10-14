local suggestion = SMODS.Joker {
	key = 'suggestion',
	loc_txt = {
		name = 'Suggestion',
		text = {
			"Scoring {C:attention}Face Cards",
			"become {C:attention}Queens",
			caption..'"I have a suggestion."'
		}
	},
	blueprint_compat = true,
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 6, y = 1 },
	cost = 9
}

suggestion.calculate = function(self, card, context)
	if context.before and not context.blueprint then
		local faces = 0
		for _, scored_card in ipairs(context.scoring_hand) do
			if scored_card:is_face() and scored_card:get_id() ~= 12 then
				faces = faces + 1
				assert(SMODS.change_base(scored_card, nil, 'Queen'))
				G.E_MANAGER:add_event(Event({
					func = function()
						scored_card:juice_up()
						return true
					end
				}))
			end
		end
		if faces > 0 then
			return {
				message = "Forcefem!",
				colour = G.ARGS.LOC_COLOURS['elle']
			}
		end
	end
end