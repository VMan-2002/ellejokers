local elle = SMODS.Joker {
	key = 'elle',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = table_create_badge(elle_badges.oc) end end,
	config = { extra = {
		xmult_mod = 0.1,
	}},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_mod*elle_bsky_count } }
	end,
	rarity = 4,
	atlas = 'legendary',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	cost = 20,
	blueprint_compat = true,
	unlocked = false
}

elle.calculate = function(self, card, context)
	if context.end_of_round then elle_update_follower_count() end
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				Xmult = elle_bsky_count * card.ability.extra.xmult_mod
			}
		end
	end
end


-- this is largely taken from cryptid								and alexi <3
local gmm = Game.main_menu
Game.main_menu = function(change_context, ...)
    local ret = gmm(change_context, ...)

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.05,
        blockable = false,
        blocking = false,
        func = function()
            local newcard = Card(
                G.title_top.T.x,
                G.title_top.T.y,
                G.CARD_W,
                G.CARD_H,
                G.P_CARDS.empty,
                G.P_CENTERS.j_elle_elle, -- replace this with whatever card
                { bypass_discovery_center = true }
            )

            -- avoid changing the cardarea dimensions if something did that already
            if #G.title_top.cards <= 1 then
                G.title_top.T.w = G.title_top.T.w * 1.7675
                G.title_top.T.x = G.title_top.T.x - 0.8
            end

            G.title_top:emplace(newcard)
            newcard:start_materialize(nil, false, 1)
            newcard.T.w = newcard.T.w * 1.1 * 1.2
            newcard.T.h = newcard.T.h * 1.1 * 1.2
            newcard.no_ui = true
            newcard:set_sprites(newcard.config.center)

            return true
        end
    }))

    return ret
end