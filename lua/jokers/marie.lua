SMODS.Joker {
	key = 'marie',
	loc_txt = {
		name = 'Marie',
		text = {
			"Retrigger every Joker once",
			caption.."The Mall's Admin...",
			caption.."Not very good at her job."
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	blueprint_compat = true,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 4,
	atlas = 'legendary',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	unlocked = false,
	cost = 20,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card ~= self then
			return {
				message = "Again!",
				repetitions = 1,
				card = card
			}
		end
	end
}