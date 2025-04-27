--		[[ To-Do List ]]
--	- Vacancy functionality
--		- may just not include in this version
--	- Ideas for Sarah, and "Sarah"
--		- may remove sarah jokers from this version
--	- New Joker art
--		- Chloe
--		- "Chloe"
--		- Furry
--		- Drago
--		- Sophie
--		- Sarah
--		- "Sarah"
--	- More Jokers????
--		- pls don't scope creep i swear to god-
--	- Suggestive mode texture toggle
--		- gonna disable this for now


--		[[ Atlases ]]
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "consumables",
	path = "consumables.png",
	px = 71,
	py = 95,
}


--		[[ Sounds ]]
-- Gulp (vore)
--[[SMODS.Sound {
	key = "elle_gulp",
	path = "gulp.ogg"
}
-- Burp (also vore)
SMODS.Sound {
	key = "elle_burp",
	path = "burp.ogg"
}]]


--		[[ Config / Optional Features ]]
-- Optional Features
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true }
end

-- Mod Config
-- i give up on this for now,, maybe next update :p
--[[elle_config = SMODS.current_mod.config
SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = { align = "cm", no_fill = true }, nodes = {
		{n = G.UIT.C, config = { align = "cm", no_fill = true }, nodes = {
			{n = G.UIT.R, config = { no_fill = true }, nodes = {
				{n = G.UIT.T, config = { align = "cm", text = "Silly Toggle", colour = G.C.UI.TEXT_LIGHT, scale = .5 }}}},
			{n = G.UIT.R, config = { no_fill = true }, nodes = { create_toggle({
				ref_table = elle_config,
				ref_value = "silly_mode",
				label = "(16+) Toggle Silly mode"
			})}},
			{n = G.UIT.R, config = { align = "cm", no_fill = true }, nodes = {
				{n = G.UIT.T, config = { align = "cm", text = "Changes some textures and stuff :3", colour = G.C.UI.TEXT_LIGHT, scale = .25 }}}},
			{n = G.UIT.R, config = { align = "cm", no_fill = true }, nodes = {
				{n = G.UIT.T, config = { align = "cm", text = "why am i doing this", colour = G.C.UI.TEXT_LIGHT, scale = .25 }}}}
		}}
	}}
end]]

-- Text Colours
loc_colour('red')
G.ARGS.LOC_COLOURS['elle'] = HEX('FF53A9')
G.ARGS.LOC_COLOURS['e_possessed'] = HEX('B7A2FD')

-- Text Prefix Shortcuts
local caption = '{C:elle,s:0.7,E:1}'
local caption_p = '{C:e_possessed,s:0.7,E:1}'


--		[[ Parasite Upgrades ]]
-- Jokers that can be upgraded by the Parasite consumable. [vars] table lets values carry over.
elle_parasite_upgrades = {
	["j_joker"] = { upgrade = "j_elle_parajoker" },
	["j_jolly"] = { upgrade = "j_elle_jolly_parasite" },
	["j_elle_chloe"] = { upgrade = "j_elle_furry" },
	["j_elle_furry"] = { upgrade = "j_elle_furry2", vars = { ["mult"] = "mult" } },
	["j_elle_furry2"] = { upgrade = "j_elle_chesh" },
	["j_elle_sarah"] = { upgrade = "j_elle_sarah2" },
	["j_elle_sarah2"] = { upgrade = "j_elle_chesh" },
	["j_elle_drago"] = { upgrade = "j_elle_symbiosis" },
	["j_elle_marie"] = { upgrade = "j_elle_admin" }
}

function parasite_upgrade(joker)
	local _c = joker
	local _j_key = _c.config.center.key
	local _upgrade = elle_parasite_upgrades[_j_key]
	
	local _vars = {}
	if _upgrade.vars ~= nil then
		for i,v in pairs(_upgrade.vars) do
			_vars[i] = _c.ability.extra[v]
		end
	end
	if (_upgrade) ~= nil then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = .1,
			func = function()
				_c:flip()
				delay(.5)
				play_sound('tarot1')
				_c:juice_up(.8,.8)
				
				if Cryptid ~= nil then _c:set_ability(G.P_CENTERS[_upgrade.upgrade], true, nil)
				else _c:set_ability(_upgrade.upgrade) end
				
				
				_c.sell_cost = _c.config.center.cost
				
				for i,v in pairs(_vars) do
					_c.ability.extra[i] = v
				end
				_c:flip()
				return true
			end
		}))
	end
end

-- Cryptid/Talisman Compatibility functions
function elle_prob(card,p_key,odds)
	if Cryptid ~= nil then return cry_prob(card.ability.cry_prob, odds, card.ability.cry_rigged) end
	return pseudorandom(p_key) < G.GAME.probabilities.normal / odds
end

function elle_prob_loc(card,odds)
	if Cryptid ~= nil then return card.ability.cry_rigged and odds or (G.GAME.probabilities.normal * (card.ability.cry_prob or 1)) end
	return (G.GAME.probabilities.normal or 1)
end

to_big = to_big or function(x) return x end


--		[[ Jokers ]]
-- Parasite Joker (Uncommon)
SMODS.Joker {
	key = 'elle_parajoker',
	loc_txt = {
		name = 'Parasite Joker',
		text = {
			"{C:mult}+#1#{} Mult",
			"{C:chips}+#2#{} Chips"
		}
	},
	config = { extra = { mult = 8, chips = 16 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	parasite_retrigger = true,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				extra = { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } } }
			}
		end
	end
}

-- Jolly Parasite (Uncommon)
SMODS.Joker {
	key = 'elle_jolly_parasite',
	loc_txt = {
		name = 'Jolly Parasite',
		text = {
			"{C:mult}+#1#{} Mult and {C:green}#2# in #3#{} chance for",
			"a {C:spectral}Parasite{} card if played",
			"hand contains a {C:attention}Pair"
		}
	},
	config = { extra = { mult = 16, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, elle_prob_loc(card, card.ability.extra.odds), card.ability.extra.odds } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 2 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	parasite_retrigger = true,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands['Pair']) then
			if elle_prob(card, 'elle_jolly_parasite', card.ability.extra.odds) then
				SMODS.add_card({
					set = "Spectral",
					area = G.consumeables,
					key = "c_elle_parasite"
				})
			end
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
			}
		end
	end
}

-- Chloe Joker (Common)
SMODS.Joker {
	key = 'elle_chloe',
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
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.discard then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
		end
		if context.end_of_round then
			card.ability.extra.chips = 0
		end
		if context.joker_main then
			if card.ability.extra.chips ~= 0 then
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
				}
			end
		end
	end
}

-- "Chloe" Joker (Uncommon)
SMODS.Joker {
	key = 'elle_furry',
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
	pos = { x = 2, y = 0 },
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

-- Furry Joker (Rare)
SMODS.Joker {
	key = 'elle_furry2',
	loc_txt = {
		name = 'Furry',
		text = {
			"This joker gains {C:mult}+#1#{} Mult every",
			"time a card is destroyed",
			"{C:green}#3# in #4# chance{} to turn played",
			"cards into {C:attention}Glass{} cards",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			" ",
			caption_p.."Chloe always sucked at names~"
		}
	},
	config = { extra = { mult_mod = 8, mult = 0, odds = 8 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, elle_prob_loc(card, card.ability.extra.odds), card.ability.extra.odds } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
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
					v:set_ability(G.P_CENTERS.m_glass, nil, true)
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

-- Cheshire Joker (Rare)
SMODS.Joker {
	key = 'elle_chesh',
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
	config = { extra = { Xmult_mod = 0.1, Xmult = 1, vore = 4, drago_mod = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	cost = 8,
	parasite_retrigger = true,
	parasite_bypass = true,
	blueprint_compat = true,
	unlocked = false,
	calculate = function(self, card, context)
		-- Trading Card but vore
		if context.destroying_card and G.GAME.current_round.hands_played == 0 and not context.blueprint and #context.full_hand == 1 then
			if context.cardarea == G.play then
				local _card = context.full_hand[1]
				
				local _texts = {"*Stab*", "Nom~", "Tasty~"}
				local _snd = 'slice1'
				
				--[[if elle_config.silly_mode then
					_texts = {"GLLP~", "Yum~", "UURP~", "Nom~", "Tasty~"}
					_snd = 'elle_gulp'
				end]]
				local _txt = _texts[math.random(#_texts)].." (+X"..card.ability.extra.Xmult_mod..")"
				
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
				G.E_MANAGER:add_event(Event({func = function()
					card:juice_up(.4,.4)
					_card:start_dissolve({HEX("8A71E1")}, nil, 1.6)
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
		
		-- Secret Drago interaction (girlfood)
		--		1/4 chance to eat Drago and get +X2. If Drago has an edition, inherit that edition
		if context.end_of_round and context.cardarea == G.jokers and #find_joker("j_elle_drago") > 0 and not context.blueprint and not context.retrigger_joker and elle_prob(card, 'elle_chesh_vore', card.ability.extra.vore) then
			local _girlfood = find_joker("j_elle_drago")[1]
			local _ed = _girlfood.edition
			
			local _txt = "Pathetic."
			local _snd = 'slice1'
			
			--[[if elle_config.silly_mode then
				_txt = "UUOARHHP~!!"
				_snd = 'elle_burp'
			end]]
			
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.joker_buffer = 0
				
				if _ed ~= nil then card:set_edition(_ed.key) end
				
				card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + card.ability.extra.drago_mod
				card:juice_up(.8,.8)
				_girlfood:start_dissolve({HEX("8A71E1")}, nil, 1.6)
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

-- Sophie Joker (Uncommon)
SMODS.Joker {
	key = 'elle_sophie',
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
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 5, y = 0 },
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


-- Sarah Joker (Uncommon)
-- [Needs Idea/Code]
--[[
SMODS.Joker {
	key = 'elle_sarah',
	loc_txt = {
		name = 'Sarah',
		text = {
			"{C:inactive}test thingy"
		}
	},
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = true
}

-- "Sarah" Joker (Rare)
-- [Needs Idea/Code]
SMODS.Joker {
	key = 'elle_sarah2',
	loc_txt = {
		name = '"Sarah"',
		text = {
			"{C:inactive}test thingy"
		}
	},
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 1, y = 1 },
	cost = 5,
	blueprint_compat = true,
	in_pool = function(self) return false end,
	no_doe = true,
	parasite_retrigger = true
}--]]

-- Drago Joker (Uncommon)
SMODS.Joker {
	key = 'elle_drago',
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
	pos = { x = 1, y = 1 },
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

-- Symbiosis Joker (Rare)
SMODS.Joker {
	key = 'elle_symbiosis',
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
	pos = { x = 2, y = 1 },
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

-- Marie Joker (Legendary)
SMODS.Joker {
	key = 'elle_marie',
	loc_txt = {
		name = 'Marie',
		text = {
			"Retrigger all",
			"{C:common}Common{} Jokers",
			" ",
			caption.."Let's try that again..."
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
	pos = { x = 4, y = 1 },
	soul_pos = { x = 4, y = 2 },
	unlocked = false,
	cost = 6,
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

-- Admin Joker (Legendary)
SMODS.Joker {
	key = 'elle_admin',
	loc_txt = {
		name = 'Administrator',
		text = {
			"Retrigger all other",
			"{C:e_possessed}Parasite Upgraded{} Jokers",
			" ",
			caption_p.."It's about time."
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
	pos = { x = 5, y = 1 },
	soul_pos = { x = 5, y = 2 },
	cost = 6,
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

--		[[ Consumables ]]
-- Parasite
SMODS.Consumable {
	key = 'elle_parasite',
	set = 'Spectral',
	loc_txt = {
		name = "Parasite",
		text = {
			"Can {C:e_possessed}\"Upgrade\"{} specific Jokers.",
			"Carries over values when applicable.",
			"Destroys #1# random cards in hand"
		}
	},
	config = { extra = { cards = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	cost = 8,
	atlas = 'consumables',
	pos = { x = 1, y = 0 },
	can_use = function(self, card)
		-- immediately ignore if the init conditions aren't true
		if (#G.jokers.highlighted ~= 1 or #G.hand.cards < 3) then return false end
		
		local _curr = G.jokers.highlighted[1]
		
		if (elle_parasite_upgrades[_curr.config.center.key] == nil) then return false end
		
		local _upgr = G.P_CENTERS[elle_parasite_upgrades[_curr.config.center.key].upgrade]
		
		return (_upgr.unlocked or _upgr.parasite_bypass)
	end,
	use = function(self, card, area, copier)
		-- Code I took from Immolate (and tweaked ofc)
		local destroyed_cards = {}
		local temp_hand = {}
		for k, v in ipairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
		table.sort(temp_hand, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
		pseudoshuffle(temp_hand, pseudoseed('elle_parasite'))

		for i = 1, card.ability.extra.cards do destroyed_cards[#destroyed_cards+1] = temp_hand[i] end

		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
			return true end }))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function() 
				for i=#destroyed_cards, 1, -1 do
					local card = destroyed_cards[i]
					if card.ability.name == 'Glass Card' then 
						card:shatter()
					else
						card:start_dissolve(nil, i == #destroyed_cards)
					end
				end
				return true end }))
		delay(0.5)
		
		-- Card Upgrading
		parasite_upgrade(G.jokers.highlighted[1])
	end
}

-- Resident
--[[SMODS.Consumable {
	key = 'elle_resident',
	set = 'Spectral',
	loc_txt = {
		name = "Resident",
		text = {
			"Gives a random",
			"{C:elle}Resident{} Joker."
		}
	},
	cost = 4,
	atlas = 'consumables',
	pos = { x = 0, y = 1 },
	config = { extra = { } },
	loc_vars = function(self, info_queue, card) return { vars = { } } end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		SMODS.add_card({
			set = "Residents",
			area = G.jokers
		})
	end
}]]--