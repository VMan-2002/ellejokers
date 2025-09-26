local elle = SMODS.Joker {
	key = 'elle',
	loc_txt = {
		name = 'ellestuff.',
		text = {
			"{X:mult,C:white}X#1#{} Mult per {C:attention}Follower",
			"on {C:elle}elle.{}'s {C:blue}BlueSky{} account",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
			caption.."obligatory self-insert legendary",
			"{C:inactive,s:0.7}@ellestuff.dev btw :3"
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.oc() end,
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
	unlocked = false,
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