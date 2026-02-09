local j = SMODS.Joker {
	key = 'p41',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.mall) end end,
	config = { extra = { trigger = false, spr = false } },
	loc_vars = function(self, info_queue, card)
		local ret = { vars = { "#" } }
		-- Copied from VanillaRemade Brainstorm
        if card.area and card.area == G.jokers then
			local card_pos = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then card_pos = i break end
			end
			
            local left = G.jokers.cards[card_pos-1] and G.jokers.cards[card_pos-1] ~= card and
                G.jokers.cards[card_pos-1].config.center.blueprint_compat
            
			local right = G.jokers.cards[card_pos+1] and G.jokers.cards[card_pos+1] ~= card and
                G.jokers.cards[card_pos+1].config.center.blueprint_compat
            
			local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = left and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (left and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        },
						{
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = right and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (right and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            ret.main_end = main_end
        end
		
		return ret
    end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 0, y = 4 },
	soul_pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = true
}

j.calculate = function(self, card, context)
	-- Start Retriggering
	if context.before then
		local hasAce = false
		local has4 = false
		for _, v in pairs(context.full_hand) do
			has4 = has4 or v:get_id() == 4
			hasAce = hasAce or v:get_id() == 14
		end
		
		if has4 and hasAce then
			card.ability.extra.trigger = true
			G.E_MANAGER:add_event(Event({func = function() card.ability.extra.spr = true return true end }))
			return { message = localize("elle_41_activate"), colour = G.C.BLUE }
		end
	end
	-- Retrigger
	if card.ability.extra.trigger then
		-- Stop Retriggering
		if context.after then
			card.ability.extra.trigger = false
			G.E_MANAGER:add_event(Event({func = function() card.ability.extra.spr = false return true end }))
			return {}
		end
		
		local card_pos = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then card_pos = i break end
		end
		
        local retl = SMODS.blueprint_effect(card, G.jokers.cards[card_pos-1], context)
        local retr = SMODS.blueprint_effect(card, G.jokers.cards[card_pos+1], context)
        if retl then
			retl.colour = G.C.BLUE
			SMODS.calculate_effect(retl, card)
		end
        if retr then
			retr.colour = G.C.BLUE
			SMODS.calculate_effect(retr, card)
		end
	end
end

j.update = function(self, card, dt) if card.area == G.jokers then card.children.center:set_sprite_pos({x = 0, y = card.ability.extra.spr and 5 or 4}) end end