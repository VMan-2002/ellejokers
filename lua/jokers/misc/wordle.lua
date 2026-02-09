local wordle = SMODS.Joker {
	key = 'wordle',
	config = { extra = { xmult = 1, xmult_mod = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 5, y = 4 },
	cost = 9,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					ellejokers.wordle.begin_game(card)
					return true
				end,
			}))
		end
		
		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
	end
}

ellejokers.wordle = {
	state = false,
	char_list = "abcdefghijklmnopqrstuvwxyz",
	word_list = {
		"aabcd"
	},
	guesses = {},
	game_card = nil,
	ui = nil
}
G.E_MANAGER.queues.elle_wordle = {}

function ellejokers.wordle.begin_game(card)
	ellejokers.wordle.game_card = card
	ellejokers.wordle.state = true
	ellejokers.wordle.ui = ellejokers.wordle.create_ui(ellejokers.wordle.game_card)
	
	G.E_MANAGER:add_event(Event({
		func = function()
			return not ellejokers.wordle.state
		end
	}))
end