--		[[ Common ]]
-- Chloe
SMODS.Joker {
	key = 'chloe',
	loc_txt = {
		name = 'Chloe',
		text = {
			"Gain {C:chips}+#1#{} Chips every",
			"time you {C:attention}discard{} a card.",
			"Amount resets at end",
			"of round",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	config = { extra = { chip_mod = 4, chips = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.discard then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_mod } },
				colour = G.C.CHIPS
			}
		end
		if context.end_of_round then
			card.ability.extra.chips = 0
		end
		if context.joker_main then
			if card.ability.extra.chips ~= 0 then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chip', vars = { card.ability.extra.chips } },
					colour = G.C.CHIPS
				}
			end
		end
	end
}

-- Drago
SMODS.Joker {
	key = 'drago',
	loc_txt = {
		name = 'Drago',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			" ",
			caption.."Genuinely pathetic",
			"{C:inactive,s:0.7}Character belongs to",
			"{C:inactive,s:0.7}@dragothedemon.bsky.social"
		},
		unlock = {
			"Reach {X:mult,C:white}X2{} Mult",
			"on {C:attention}Cheshire"
		}
	},
	config = { extra = { Xmult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 5, y = 0 },
	cost = 1,
	blueprint_compat = true,
	unlocked = false,
	check_for_unlock = function(self, args)
		return args.type == "elle_drago"
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
			}
		end
	end
}


--		[[ Uncommon ]]
-- Parasite
SMODS.Joker {
	key = 'parajoker',
	loc_txt = {
		name = 'Parasite Joker',
		text = {
			"{C:mult}+#1#{} Mult",
			"{C:chips}+#2#{} Chips",
			"{C:mult}+#1#{} Mult and {C:green}#2# in #3#{} chance for",
			"a {C:spectral}Parasite{} card"
		}
	},
	config = { extra = { mult = 8, chips = 16, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	parasite_retrigger = true,
	calculate = function(self, card, context)
		if context.joker_main then
			if elle_prob(card, 'elle_jolly_parasite', card.ability.extra.odds) then
				SMODS.add_card({
					set = "Spectral",
					area = G.consumeables,
					key = "c_elle_parasite"
				})
			end
			
			return {
				mult_mod = card.ability.extra.mult,
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				extra = { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }, colour = G.C.CHIPS }
			}
		end
	end
}

-- "Chloe"
SMODS.Joker {
	key = 'furry',
	loc_txt = {
		name = '"Chloe"',
		text = {
			"This joker gains {C:mult}+#1#{} Mult",
			"every time a card",
			"is destroyed",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			" ",
			caption.."Something about her seems off..."
		}
	},
	config = { extra = { mult_mod = 5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	parasite_retrigger = true,
	calculate = function(self, card, context)
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
}

-- Sarah
SMODS.Joker {
	key = 'sarah',
	loc_txt = {
		name = 'Sarah',
		text = {
			"All {C:attention}scoring cards{} are",
			"considered the first",
			" ",
			caption.."Let's try that again..."
		}
	},
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 2, y = 3 },
	cost = 9,
	calculate = function(self, card, context)
		if context.cardarea == G.play and not context.retrigger_joker and context.individual then
			for k, v in ipairs(context.scoring_hand) do
				if (v == context.other_card) then
					table.remove(context.scoring_hand, k)
					table.insert(context.scoring_hand, 1, context.other_card)
				end
			end
		end
	end
}

-- Check It Out
SMODS.Joker {
	key = 'carpet',
	loc_txt = {
		name = 'Check It Out',
		text = {
			"This joker gains {X:mult,C:white}X#1#{} Mult",
			"if played hand contains",
			"a {C:attention}Full House",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	config = { extra = { xmult_mod = 0.25, xmult = 1 } },
	loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } } end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 3 },
	blueprint_compat = true,
	cost = 9,
	calculate = function(self, card, context)
		if context.joker_main then
			if next(context.poker_hands['Full House']) then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				return {
					message = "Carpet (+X"..(card.ability.extra.xmult_mod)..")",
					sound = 'elle_carpet',
					colour = G.C.MULT,
					extra = {
						Xmult_mod = card.ability.extra.xmult,
						message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
					}
				}
			end
			if card.ability.extra.xmult ~= 1 then
				return {
					Xmult_mod = card.ability.extra.xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
				}
			end
		end
	end
}

-- Winsweep
SMODS.Joker {
	key = 'winsweel',
	loc_txt = {
		name = 'Winsweep',
		text = {
			"This joker gains {X:mult,C:white}X#1#{} Mult",
			"for each consecutive",
			"{C:attention}First Hand{} win",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
			" ",
			caption.."Winsweep never loses!",
			"{C:inactive,s:0.7}Character from",
			"{C:inactive,s:0.7}Content SMP"
		}
	},
	config = { extra = { xmult = 1, xmult_mod = 0.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	cost = 8,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			if (G.GAME.current_round.hands_played == 1) then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				
				card:juice_up(.1,.1)
				return {
					message = "Win! (+X"..card.ability.extra.xmult_mod..")"
				}
			elseif (card.ability.extra.xmult ~= 1) then
				card.ability.extra.xmult = 1
				
				card:juice_up(.1,.1)
				return {
					message = "Reset"
				}
			end
		end
		if context.joker_main then
			if card.ability.extra.xmult ~= 1 then
				return {
					xmult_mod = card.ability.extra.xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
				}
			end
		end
	end
}


--		[[ Rare ]]
-- Furry
SMODS.Joker {
	key = 'furry2',
	loc_txt = {
		name = 'Furry',
		text = {
			"This joker gains {C:mult}+#1#{} Mult every",
			"time a card is destroyed",
			"{C:green}#3# in #4# chance{} to turn played",
			"cards into {C:attention}Slimed Cards",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			" ",
			caption_p.."Chloe always sucked at names~"
		}
	},
	config = { extra = { mult_mod = 8, mult = 0, odds = 8 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_elle_slimed
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, elle_prob_loc(card, card.ability.extra.odds), card.ability.extra.odds } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 7,
	blueprint_compat = true,
	parasite_retrigger = true,
	in_pool = function(self) return false end,
	no_doe = true,
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
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
		if context.before and context.cardarea == G.jokers then
			local stabs = {}
			for k, v in ipairs(context.scoring_hand) do
				if elle_prob(card, 'elle_furry2', card.ability.extra.odds) then
					stabs[#stabs+1] = v
					v:set_ability(G.P_CENTERS.m_elle_slimed, nil, true)
					v:juice_up(0.3,0.4)
				end
			end
			if #stabs > 0 then 
				return {
					message = "*Stab*",
					card = self
				}
			end
		end
	end
}

-- Cheshire
SMODS.Joker {
	key = 'chesh',
	loc_txt = {
		name = 'Cheshire',
		text = {
			"If {C:attention}first hand{} of round",
			"has a single card, destroy",
			"it and gain {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
			" ",
			caption_p.."Finally flying solo!"
		},
		unlock = {
			"{C:e_possessed}\"Upgrade\"{} into",
			"this {C:attention}Joker"
		}
	},
	config = { extra = { Xmult_mod = 0.1, Xmult = 1, drago = 4, drago_mod = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 8,
	parasite_retrigger = true,
	parasite_bypass = true,
	blueprint_compat = true,
	unlocked = false,
	calculate = function(self, card, context)
		-- Trading Card but xmult
		if context.destroying_card and G.GAME.current_round.hands_played == 0 and not context.blueprint and #context.full_hand == 1 then
			if context.cardarea == G.play then
				local _card = context.full_hand[1]
				
				local _texts = {"*Stab*", "Nom~", "Tasty~"}
				local _snd = 'slice1'
				
				local _txt = _texts[math.random(#_texts)].." (+X"..card.ability.extra.Xmult_mod..")"
				
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
				G.E_MANAGER:add_event(Event({func = function()
					card:juice_up(.4,.4)
					_card:shatter()
					play_sound(_snd, 1)
				return true end }))
				
				if card.ability.extra.Xmult >= 2 then check_for_unlock({type="elle_drago"}) end
				
				return {
					message_card = card,
					remove = true,
					message = _txt,
					colour = G.C.RED
				}
			end
		end
		
		-- Secret Drago interaction (girlfail)
		--		1/4 chance to destroy Drago and get +X2. If Drago has an edition, inherit that edition
		if context.end_of_round and context.cardarea == G.jokers and #find_joker("j_elle_drago") > 0 and not context.blueprint and not context.retrigger_joker and elle_prob(card, 'elle_chesh_drago', card.ability.extra.drago) then
			local _girlfood = find_joker("j_elle_drago")[1]
			local _ed = _girlfood.edition
			
			local _txt = "Pathetic."
			local _snd = 'slice1'
			
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.joker_buffer = 0
				
				if _ed ~= nil then card:set_edition(_ed.key) end
				
				card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + card.ability.extra.drago_mod
				card:juice_up(.8,.8)
				_girlfood:shatter()
				play_sound(_snd)
			return true end }))
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = _txt.." (+X"..card.ability.extra.drago_mod..")", colour = G.C.RED})
			
			check_for_unlock({type="elle_symbiosis"})
		end
		
		-- XMult stuff
		if context.joker_main then
			if card.ability.extra.Xmult ~= 0 then
				return {
					Xmult_mod = card.ability.extra.Xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
			end
		end
	end
}

-- Sophie
SMODS.Joker {
	key = 'sophie',
	loc_txt = {
		name = 'Sophie',
		text = {
			"This joker gains {C:mult}+#1#{} Mult",
			"for each additional multiple of",
			"{C:attention}Round Score{} reached",
			"at end of round",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			" ",
			caption.."It burns so good~"
		},
		unlock = {
			"Reach {C:attention}10x",
			"Blind Score"
		}
	},
	config = { extra = { mult_mod = 2, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	cost = 6,
	unlocked = false,
	blueprint_compat = true,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then return G.GAME.chips/G.GAME.blind.chips >= to_big(10) end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and math.floor(G.GAME.chips / G.GAME.blind.chips) ~= 1 then
			local _mult = (math.floor(G.GAME.chips / G.GAME.blind.chips)-1) * card.ability.extra.mult_mod
			
			card.ability.extra.mult = card.ability.extra.mult + _mult
			
			card:juice_up(.1,.1)
			return {
				message = "Hehe~ (+".._mult..")"
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
}

-- Symbiosis
SMODS.Joker {
	key = 'symbiosis',
	loc_txt = {
		name = 'Symbiosis',
		text = {
			"When a card is destroyed",
			"{C:green}#1# in #2#{} chance to create",
			"a random {C:negative}Negative {C:tarot}Tarot{} card",
			"{C:green}#3# in #4#{} chance to create",
			"a {C:negative}Negative {C:spectral}Spectral{} card instead",
			" ",
			caption_p.."It’s so warm... kinda cozy...",
			"{C:inactive,s:0.7}Character belongs to",
			"{C:inactive,s:0.7}@dragothedemon.bsky.social"
		},
		unlock = {
			"Destroy {C:attention}Drago{} through",
			"{C:e_possessed}unorthodox means{}..."
		}
	},
	config = { extra = { tarot = 4, spectral = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { elle_prob_loc(card, card.ability.extra.tarot), card.ability.extra.tarot, elle_prob_loc(card, card.ability.extra.spectral), card.ability.extra.spectral } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 6, y = 0 },
	cost = 7,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	unlocked = false,
	parasite_retrigger = true,
	check_for_unlock = function(self, args)
		return args.type == "elle_symbiosis"
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			for i, v in ipairs(context.removed) do
				if elle_prob(card,'elle_symbiosis-tarot',card.ability.extra.tarot) and #G.consumeables.cards < G.consumeables.config.card_limit then
					local _set = "Tarot"
					if elle_prob(card, 'elle_symbiosis-spectral', card.ability.extra.spectral) then _set = "Spectral" end
					
					SMODS.add_card({
						set = _set,
						area = G.consumeables,
						edition = 'e_negative'
					})
				end
			end
		end
	end
}

-- Polyamory
SMODS.Joker {
	key = 'polyamory',
	loc_txt = {
		name = 'Polyamory',
		text = {
			"If played hand {C:attention}consists",
			"of at least {C:attention}#1#{} cards,",
			"all with the {C:attention}same rank{},",
			"convert all scoring",
			"cards into {C:hearts}Hearts"
		}
	},
	config = { extra = { count = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.count } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	cost = 8,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and next(context.poker_hands['Three of a Kind']) then
			local hearts = {}
			
			for k, v in ipairs(context.scoring_hand) do
				hearts[#hearts+1] = v
				if (v.base.value ~= hearts[1].base.value) then
					hearts = {}
					break
				end
			end
			
			if #hearts >= card.ability.extra.count then
				for k, v in ipairs(context.scoring_hand) do
					v:change_suit("Hearts")
					v:juice_up(0.3,0.4)
				end
				return {
					message = "<3",
					card = self
				}
			end
		end
	end
}

-- Lucidity
SMODS.Joker {
	key = 'lucidity',
	loc_txt = {
		name = 'Lucidity',
		text = {
			"Shows the next {C:attention}#1#",
			"cards in the deck"
		}
	},
	loc_vars = function(self, info_queue, card)
		local list = {}
		if next(SMODS.find_card('j_elle_lucidity')) and #G.deck.cards > 0 then
			local topCards = CardArea(0,0,4+(math.min(card.ability.extra.cards,#G.deck.cards)*.2),3,{type = 'title', card_limit = 3})
			for i = 1, card.ability.extra.cards do
				if (#G.deck.cards < i) then break end
				
				local _c = copy_card(G.deck.cards[#G.deck.cards-i+1], nil, nil, G.playing_card)
				_c.T.w = G.CARD_W*.75
				_c.T.h = G.CARD_H*.75
				topCards:emplace(_c)
				_c.facing='front'
			end
			
			list = {{
				n = G.UIT.O,
				config = { object = topCards }
			}}
		end
		
		return { vars = { card.ability.extra.cards }, main_end = list }
	end,
	config = { extra = { cards = 3 } },
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 0, y = 3 },
	cost = 9
}


--		[[ Legendary ]]
-- Marie
SMODS.Joker {
	key = 'marie',
	loc_txt = {
		name = 'Marie',
		text = {
			"Retrigger all",
			"{C:common}Common{} Jokers",
			" ",
			caption.."You can do this!"
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	blueprint_compat = true,
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 2, y = 1 },
	soul_pos = { x = 2, y = 2 },
	unlocked = false,
	cost = 20,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card ~= self and context.other_card.config.center.rarity == 1 then
			return {
				message = "Again!",
				repetitions = 1,
				card = card
			}
		end
	end
}

-- Admin
SMODS.Joker {
	key = 'admin',
	loc_txt = {
		name = 'Administrator',
		text = {
			"Retrigger all other",
			"{C:attention}Parasite Upgraded{} Jokers",
			" ",
			caption_p.."Zero consequences."
		},
		unlock = {
			"{C:e_possessed}\"Upgrade\"{} into",
			"this {C:attention}Joker"
		}
	},
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 3, y = 1 },
	soul_pos = { x = 3, y = 2 },
	cost = 20,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	unlocked = false,
	parasite_bypass = true,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and context.other_card.config.center.parasite_retrigger then
			return {
				message = "Again!",
				repetitions = 1,
				card = card
			}
		end
	end
}

-- Twylight
SMODS.Joker {
	key = 'twy',
	loc_txt = {
		name = 'TwyLight',
		text = {
			"If played hand contains",
			"a {C:attention}Straight{}, destroy all",
			"played cards and gain",
			"{X:mult,C:white}X#1#{} Mult each",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
			" ",
			caption.."99... 100! This is too many tails~,,",
			"{C:inactive,s:0.7}Character belongs to",
			"{C:inactive,s:0.7}@twylightstar.bsky.social"
		},
		unlock = {
			"{E:1,s:1.3}?????"
		}
	},
	config = { extra = { xmult_mod = 0.2, xmult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 4, y = 1 },
	soul_pos = { x = 4, y = 2 },
	cost = 20,
	in_pool = function(self) return false end,
	unlocked = false,
	calculate = function(self, card, context)
		if context.destroying_card and next(context.poker_hands['Straight']) and not context.blueprint then
			if context.cardarea == G.play then
				local _card = context.destroying_card
				
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					card:juice_up(.4,.4)
					_card:start_dissolve({HEX("FFAE36")}, nil, 1.6)
				return true end }))
				return {
					message_card = card,
					remove = true,
					message = "+X"..card.ability.extra.xmult_mod,
					colour = G.C.MULT
				}
			end
			
		end
		
		if context.joker_main then
			if card.ability.extra.xmult ~= 1 then
				return {
					Xmult_mod = card.ability.extra.xmult,
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
				}
			end
		end
	end
}

