return {
	descriptions = {
		Joker = {
			-- Canon OCs
			j_elle_chloe = {
				name = 'Chloe',
				text = {
					"Gain {C:chips}+#1#{} Chips every",
					"time you {C:attention}discard{} a card.",
					"Amount resets at end",
					"of round",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
				},
				upgrade = {
					"{C:money}$#3#"
				}
			},
			j_elle_furry = {
				name = 'Furry',
				text = {
					"{C:attention}Once per Round:",
					"Destroy a single card",
					"and gain {C:mult}+#1#{} Mult",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive}(#3#)",
					caption..'"Chloe always sucked at names~"'
				}
			},
			j_elle_cheshire = {
				name = 'Cheshire',
				text = {
					"{C:attention}Once per Hand:",
					"Destroy a single card",
					"and gain {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"{C:inactive}(#3#)",
					caption.."Finally flying solo!"
				}
			},
			j_elle_sophie = {
				name = 'Sophie',
				text = {
					"{C:mult}+#1#{} Mult per {C:attention}overscored",
					"{C:attention}multiple{} of {C:attention}Blind Size{}",
					"{C:inactive}(Max {C:mult}+#3#{C:inactive} Mult per round)",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					caption.."Could do no wrong...?"
				},
				unlock = {
					"Reach {C:attention}10x",
					"Blind Score"
				}
			},
			j_elle_fallen = {
				name = 'Fallen Angel',
				text = {
					"{C:mult}+#1#{} Mult per {C:attention}overscored",
					"{C:attention}multiple{} of {C:attention}Blind Size{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					caption.."\"It burns so good~\""
				},
				unlock = { "Upgrade {C:attention}Sophie" }
			},
			j_elle_sarah = {
				name = 'Sarah',
				text = {
					"Scoring {C:clubs}Clubs{} have a",
					"{C:green}#1# in #2#{} chance to",
					"retrigger once",
					caption.."Keeping things working"
				}
			},
			j_elle_mint = {
				name = 'Mint',
				text = {
					"Played cards with",
					"{C:clubs}Club{} suit give",
					"{X:mult,C:white}X#1#{} Mult when scored",
					caption..'"She looks better like this."',
					caption..'"...Happier, even~"'
				},
				unlock = {
					"Make a {C:red}grave",
					"{C:red}mistake"
				}
			},
			j_elle_spearmintprog = {
				name = 'spearmint.prog',
				text = {
					"idk",
					caption..'"At your service."'
				}
			},
			j_elle_spearmint = {
				name = 'Spearmint',
				text = {
					"idk",
					caption..'"Can we wander for a spell?"'
				}
			},
			j_elle_spearlamp = {
				name = 'Spearlamp',
				text = {
					"{C:enhanced}Steel{} and {C:enhanced}Slime{} Cards",
					"{C:attention}share effects",
					caption..'This was Chloe\'s Idea...'
				}
			},
			j_elle_marie = {
				name = 'Marie',
				text = {
					"{C:attention}Slime cards{} are",
					"guaranteed to trigger"
				}
			},
			j_elle_bea = {
				name = 'Bea',
				text = {
					"Played {C:attention}cards{} permanently",
					"gain {C:mult}+#1#{} Mult when scored",
					"if played hand is a {C:attention}#2#{},",
					"poker hand changes at",
					"end of round"
				}
			},
			j_elle_rebecca = {
				name = 'Rebecca',
				text = {
					"Go to a separate {C:attention}Shop",
					"{C:attention}Restocks{} at end of Ante"
				}
			},
			j_elle_cassie = {
				name = 'Cassie',
				text = {
					"Gains {C:mult}+#1#{} Mult",
					"at {C:attention}end of round",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					caption.."Looking for her sister..."
				}
			},
			j_elle_cassie2 = {
				name = '...',
				text = {
					caption..'"You really kept it?',
					caption..'No amount of magic will',
					caption..'bring her back, you know?"'
				},
				unlock = {
					"Make a {C:red}grave",
					"{C:red}mistake"
				}
			},
			j_elle_p41 = {
				name = 'Prototype #1#41',
				text = {
					"If scoring hand contains",
					"an {C:attention}Ace{} and {C:attention}4{}, retrigger",
					"a random other {C:attention}Joker"
				}
			},
			
			-- Other stuff
			j_elle_drago = {
				name = 'Drago',
				text = {
					"{C:attention}Wild Cards{} cannot",
					"get debuffed"
				}
			},
			j_elle_vivian = {
				name = 'Vivian',
				text = {
					"{C:green}#1# in #2#{} chance to",
					"give {C:attention}scoring hand",
					"random {C:enhanced}Enhancements"
				}
			},
			j_elle_carpet = {
				name = 'Check It Out',
				text = {
					"This joker gains {X:mult,C:white}X#1#{} Mult",
					"if played hand contains",
					"a {C:attention}Full House",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
				}
			},
			j_elle_polyamory = {
				name = 'Polyamory',
				text = {
					"If played hand contains",
					"a {C:attention}Four of a Kind{},",
					"convert all scoring",
					"cards into {C:hearts}Hearts"
				}
			},
			j_elle_bf = {
				name = 'Boyfriend',
				text = {
					"{X:mult,C:white}X#1#{} Mult if you beat",
					"him in a {C:attention}Rap Battle",
					"{X:mult,C:white}X-#2#{} Mult per {C:attention}Miss",
					"Can be attempted",
					"once per round",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
					"{C:inactive}(#4#)"
				}
			},
			j_elle_nitro = {
				name = 'Discord Nitro',
				text = {
					"{C:attention}Once per Round:",
					"Pay {C:money}$#1#{} and gain",
					"{C:mult}+#2#{} Mult, resets if not",
					"paid for by end of round",
					"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
					"{C:inactive}(#4#)"
				}
			},
			j_elle_eraser = {
				name = 'Eraser',
				text = {
					"{C:attention}Once per Ante:",
					"{C:red}Ban{} a Card from",
					"{C:attention}Shops{} or {C:attention}Booster Packs",
					"for the rest of the run",
					"{C:inactive,s:0.7}(Excluding Playing Cards)",
					"{C:inactive}(#1#)"
				}
			},
			j_elle_suggestion = {
				name = 'Suggestion',
				text = {
					"All played {C:attention}face{} cards",
					"become {C:attention}Queens",
					"before scoring",
					caption..'"I have a suggestion."'
				}
			},
			
			-- Jess's Minecraft Idea
			j_elle_cobble_gen = {
				name = 'Cobblestone Generator',
				text = {
					"{C:attention}Sell{} this Joker to create",
					"{C:attention}Water Bucket{} and {C:attention}Lava Bucket",
					"{C:inactive}(Must have room)"
				}
			},
			j_elle_water_bucket = {
				name = 'Water Bucket',
				text = {
					"{C:chips}+#1#{} Chips",
					"When blind selected,",
					"if there is a single Joker",
					"between this and {C:attention}Lava Bucket{},",
					"turn it into {C:attention}Cobblestone",
					caption..'"Water Bucket, release!"'
				}
			},
			j_elle_lava_bucket = {
				name = 'Lava Bucket',
				text = {
					"When blind selected,",
					"if neighbouring {C:attention}Water Bucket{},",
					"turn into {C:attention}Obsidian"
				}
			},
			j_elle_cobblestone = {
				name = 'Cobblestone',
				text = {
					"Sell for {X:money,C:white}X#1#{} of",
					"the original Joker{C:inactive}[$#2#]"
				}
			},
			j_elle_obsidian = {
				name = 'Obsidian',
				text = {
					"{X:mult,C:white}X#1#{} Mult"
				}
			},
			
			-- Legendaries
			j_elle_twy = {
				name = 'TwyLight',
				text = {
					"At {C:attention}end of round,",
					"{C:green}#1# in #2#{} chance to",
					"{C:attention}destroy all cards{} held",
					"in hand and add {C:dark_edition}Negative{}",
					"to a random joker",
					caption.."99... 100! This is too many tails~,,",
					"{C:inactive,s:0.7}Character belongs to",
					"{C:inactive,s:0.7}@twylightstar.bsky.social"
				},
				unlock = {
					"{E:1,s:1.3}?????"
				}
			},
			j_elle_elle = {
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
		},
		Tarot = {
			c_elle_resident = {
				name = "Resident",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"cards into a",
					"{C:attention}Slime Card"
				}
			}
		},
		Enhanced = {
			m_elle_slime = {
				name = "Slime Card",
				text = {
					"{C:green}#1# in #2#{} Chance to",
					"retrigger {C:attention}#3#{} times"
				}
			}
		},
		Other = {
			elle_rebecca_challenge = {
				name = "Warning!",
				text = {
					"Rebecca's shop contents may",
					"{C:red}not save{} when closing the game",
					"This is only in {C:red}challenge runs",
					"and is likely a SMODS issue"
				}
			},
			
			slime_upgr_j_elle_chloe = {
				name = 'Upgrade..?',
				text = {
					"Discard {C:attention}#1#{C:inactive}[#2#]{}",
					"{C:attention}face{} cards"
				}
			},
			slime_upgr_j_elle_furry = {
				name = 'Upgrade',
				text = {
					"Have {C:red}Sarah{}",
					"and {C:red}Cassie{}"
				}
			},
			slime_upgr_j_elle_sophie = {
				name = 'Upgrade',
				text = {
					"Reach {C:mult}+#1#{} Mult"
				}
			},
			slime_upgr_j_elle_sarah = {
				name = 'Upgrade..?',
				text = {
					"Make a {C:red}grave",
					"{C:red}mistake"
				}
			}
		},
		Tag={
            tag_elle_rebecca={
                name="Café Tag",
                text={
                    "Restocks",
                    "{C:attention}Rebecca{}'s Shop"
                }
            }
		}
	},
	misc = {
		dictionary = {
			elle_joker_open = "OPEN",
			
			elle_rebecca_title1 = "Rebecca's Store",
			elle_rebecca_title2 = "(Formerly Slime Café)",
			elle_rebecca_booster = "BOOSTER PACK",
			elle_rebecca_joker = "JOKERS",
			elle_rebecca_consumable = "CONSUMABLES",
			elle_rebecca_reroll = "Reroll All",
			elle_rebecca_restock = "Restocked!"
		},
		challenge_names = {
			c_elle_cafe_frequent = "Café Frequent",
			c_elle_forcefem = "Forcefem!"
		},
		v_text = {
			ch_c_elle_no_shop = { "Shop is {C:attention}skipped{} at end of round" }
		}
	}
}

