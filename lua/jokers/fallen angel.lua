local fallen = SMODS.Joker {
	key = 'fallen',
	pronouns = "she_her",
	loc_txt = {
		name = 'Fallen Angel',
		text = {
			"{C:mult}+#1#{} Mult per excess",
			"{C:attention}Blind Size{} Scored at",
			"end of round",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			caption.."\"It burns so good~\""
		},
		unlock = { "Upgrade {C:attention}Sophie" }
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { mult_mod = 1, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	cost = 11,
	unlocked = false,
	in_pool = function(self) return false end,
	blueprint_compat = true,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then return G.GAME.chips/G.GAME.blind.chips >= to_big(10) end
	end
}

fallen.calculate = function(self, card, context)
	if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
		-- Add the mult stuff
		if math.floor(G.GAME.chips / G.GAME.blind.chips) > to_big(1) then
			local _mult = (math.floor(G.GAME.chips / G.GAME.blind.chips)-1) * card.ability.extra.mult_mod
			
			card.ability.extra.mult = card.ability.extra.mult + _mult
			
			card:juice_up(.1,.1)
			
			return {
				message = "Hehe~ (+".._mult..")"
			}
		end
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