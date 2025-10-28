local furry = SMODS.Joker {
	key = 'furry',
	pronouns = "she_her",
	loc_txt = {
		name = 'Furry',
		text = {
			"This joker gains {C:mult}+#1#{} Mult",
			"every time a card",
			"is destroyed",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			caption..'"Chloe always sucked at names~"'
		},
		unlock = { "Upgrade {C:attention}Chloe" }
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { mult_mod = 5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 5, y = 3 },
	cost = 5,
	blueprint_compat = true,
	unlocked = false,
	parasite_bypass = true,
	in_pool = function(self) return false end,
	no_doe = true
}

furry.calculate = function(self, card, context)
	if context.remove_playing_cards then
		local _mult = card.ability.extra.mult_mod * #context.removed
		card.ability.extra.mult = card.ability.extra.mult + _mult
		return {
			message = "Nice~ (+"..(_mult)..")"
		}
	end
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
end