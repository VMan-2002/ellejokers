local mint = SMODS.Joker {
	key = 'mint',
	pronouns = "she_her",
	loc_txt = {
		name = 'Mint',
		text = {
			"Retrigger played",
			"{C:clubs}Clubs{} cards",
			caption.."...what is wrong with you?"
		}
	},
	blueprint_compat = true,
	set_badges = function(self, card, badges) badges[#badges+1] = elle_badges.mall() end,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 5, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 5
}

mint.calculate = function(self, card, context)
	if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
		return {
			message = localize('k_again_ex'),
			repetitions = 1,
			card = card
		}
	end
end