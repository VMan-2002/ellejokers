local elle = SMODS.Joker {
	key = 'elle',
	set_badges = function(self, card, badges) if (self.discovered) then badges[#badges+1] = slimeutils.table_create_badge(elle_badges.oc) end end,
	config = { extra = {
		xmult_mod = 0.1,
	}},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_mod*ellejokers.bsky_count } }
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
	if context.end_of_round then ellejokers.update_follower_count() end
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				Xmult = ellejokers.bsky_count * card.ability.extra.xmult_mod
			}
		end
	end
end

local card_click_hook = Card.click
function Card:click()
	card_click_hook(self)
	
	if self.area == G.title_top and self.config.center_key == 'j_elle_elle' then
        play_sound('elle_squeak')
        ellejokers.mod_data.config.pixel_shader.enabled = not ellejokers.mod_data.config.pixel_shader.enabled
        check_for_unlock({type = "elle_toggle_palette"})
    end
end