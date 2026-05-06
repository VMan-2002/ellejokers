-- Text Prefix Shortcuts
local caption = '{C:elle,s:0.7,E:1}'

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
				},
				unlock = {
					"Upgrade into",
					"this card"
				}
			},
			j_elle_sophie = {
				name = 'Sophie',
				text = {
					"{C:attention}Stores{} {C:mult}+#1#{} Mult if",
					"score {C:attention}catches on fire",
					"Use to {C:attention}release{} stored",
					"Mult and {C:attention}reset",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					caption.."Could do no wrong...?"
				}
			},
			j_elle_fallen = {
				name = 'Fallen Angel',
				text = {
					"{C:attention}Stores{} {X:mult,C:white}X#1#{} Mult if",
					"score {C:attention}catches on fire",
					"Use to {C:attention}release{} stored",
					"Mult and {C:attention}reset",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					caption.."\"It burns so good~\""
				},
				unlock = {
					"Reach {C:attention}10x",
					"Blind Score"
				}
			},
			j_elle_sarah = {
				name = 'Sarah',
				text = {
					"Scoring {C:clubs}Clubs",
					"retrigger one",
					"additional time",
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
			j_elle_spearlamp_vivi = {
				name = 'Vivilamp',
				text = {
					"{C:enhanced}Steel{} and {C:enhanced}Slime{} Cards",
					"{C:attention}share effects",
					caption..'She asked for this...'
				}
			},
			j_elle_spearlamp_jess = {
				name = 'Jesslamp',
				text = {
					"{C:enhanced}Steel{} and {C:enhanced}Slime{} Cards",
					"{C:attention}share effects",
					caption..'She\'s fine.'
				}
			},
			j_elle_spearlamp_drago = {
				name = 'Dragolamp',
				text = {
					"{C:enhanced}Steel{} and {C:enhanced}Slime{} Cards",
					"{C:attention}share effects",
					caption..'Probably better like this.'
				}
			},
			j_elle_marie = {
				name = 'Marie',
				text = {
					"Upgrade {C:attention}Unenhanced",
					"playing cards into",
					"{C:attention}Slime{} cards by",
					"paying {C:money}$#1#{}, increase",
					"the cost by {C:money}$#2#",
					"afterwards"
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
					"{C:inactive}(Restocks at end of Ante)"
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
			j_elle_not_cassie = {
				name = 'Prototype #1#39',
				text = {
					"Held hand is scored",
					"{C:attention}before{} played hand",
					caption..'"I\'m sorry..."'
				},
				unlock = {
					"Beat {C:attention}???",
					"Boss Blind"
				}
			},
			j_elle_p41 = {
				name = 'Prototype #1#41',
				text = {
					"If played hand contains",
					"an {C:attention}Ace{} and {C:attention}4{},",
					"Copy abilities of",
					"neighbouring {C:attention}Jokers",
					caption.."Protected innocence..."
				}
			},
			j_elle_prototypes = {
				name = 'The Prototypes',
				text = {
					"Copy abilities of",
					"{C:attention}#1#{} random {C:attention}Jokers{},",
					"Jokers change at",
					"start of round"
				}
			},
			
			-- Other stuff
			j_elle_drago = {
				name = 'Drago',
				text = {
					"Wild Cards count as",
					"{C:attention}#1#s{} instead,",
					"{s:0.8}changes at end of round"
				}
			},
			j_elle_cheshdrago = {
				name = 'Cheshire + Drago',
				text = {
					"{C:attention}Once per Hand:",
					"Destroy a single {C:attention}Wild{} Card",
					"and gain {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"{C:inactive}(#3#)",
					caption..'"You keep crawling back~"'
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
			j_elle_feri = {
				name = 'Feri',
				text = {
					"Played {C:hearts}Hearts{} cards",
					"permanently gain",
					"{C:mult}+#1#{} Mult when scored"
				}
			},
			j_elle_ferisophie = {
				name = 'Feri + Sophie',
				text = {
					"{C:attention}Stores{} {C:mult}+#1#{} Mult when",
					"scoring a {C:hearts}Hearts{} card",
					"Use to permanently",
					"add stored Mult to",
					"played cards and {C:attention}reset",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					caption..'"You like me, right?~"'
				}
			},
			j_elle_carpet = {
				name = 'Check It Out',
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"if played hand contains",
					"a {C:attention}Full House",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
				}
			},
			j_elle_spamton = {
				name = '[[{V:1}BIG {V:2}SHOP{}]]',
				text = {
					"* ENTER MY {C:attention}[[Home-made",
					"{C:attention}Storefront Site]]",
					"{C:inactive}(Restocks at end of round)"
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
			j_elle_ourple = {
				name = 'Ourple Guy',
				text = {
					"If played hand is",
					"a {C:attention}Flush{} of {C:spades}Spades{},",
					"destroy {C:attention}#1#{} random",
					"cards in hand and",
					"gain {X:mult,C:white}X#2#{} Mult",
					"per card destroyed",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
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
			j_elle_magic_fingers = {
				name = 'Magic Fingers',
				text = {
					"Pay {C:money}$#1#{} and give",
					"{C:purple}+#2#{} Round Score",
					"{C:inactive}(Scales with ante)"
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
			j_elle_diamond_pickaxe = {
				name = "Diamond Pickaxe",
				text = {
					"{C:attention}Eternal{} Jokers can be sold",
					"by {C:attention}paying{} {C:white,X:money}X#1#{} the sell cost"
				}
			},
			j_elle_jess = {
				name = 'Jess',
				text = {
					"{C:attention}Held{} Jess cards count",
					"towards Jess {C:attention}retriggers",
					"Turn {C:attention}#1#{} played cards into",
					"{C:attention}Jess{} cards before scoring"
				}
			},
			j_elle_jessclip = {
				name = 'Heart Hairpin',
				text = {
					"{C:hearts}Hearts{} cards",
					"count towards",
					"Jess {C:attention}retriggers"
				}
			},
			j_elle_jessingit = {
				name = 'Jessing It',
				text = {
					"If all scoring cards",
					"are {C:attention}Jess Cards{},",
					"Held {C:attention}Jess Cards",
					"give {C:white,X:mult}X#1#{} Mult"
				}
			},
			j_elle_powerscaler = {
				name = 'Powerscaler',
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"when {C:attention}Upgrading{} a Joker",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
				}
			},
			j_elle_clubcard = {
				name = 'Clubcard',
				text = {
					"Cards with",
					"{C:clubs}Club{} suit",
					"give {C:money}$#1#{} when",
					"drawn to hand"
				}
			},
			j_elle_combat = {
				name = 'Combat Joker',
				text = {
					{
						"Use this Joker for",
						"{X:attention,C:white}X#1#{} blind requirements",
						"{C:green}#2# in #3#{} chance to",
						"lose {C:blue}-1{} Health instead"
					}, {
						"Recovers {C:blue}+#4#{} Health",
						"at end of round",
						"{C:inactive}(Currently {C:blue}#5#/#6#{C:inactive} Health)"
					}
				}
			},
			j_elle_bat_credit_card = {
				name = 'Bat Credit Card',
				text = {
					"Go up to {C:red}-$#1#{} in debt,",
					"Get paid back {X:money,C:white}X#2#{} your",
					"debt at end of round",
					caption..'"They gave him a BAT! CREDIT CARD?!"'
				}
			},
			
			-- Jess's Minecraft Idea
			j_elle_cobble_gen = {
				name = 'Cobblestone Generator',
				text = {
					"When blind selected, turn Joker",
					"to the left into {C:attention}Cobblestone",
					"{C:green}#1# in #2#{} chance to turn itself",
					"into an {C:attention}Eternal Obsidian{} instead"
				}
			},
			j_elle_cobble_gen_old = {
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
			
			-- Gimmicky Jokers
			j_elle_wordle = {
				name = 'Wordle',
				text = {
					{
						"Type in words and",
						"press {C:attention}Enter{} to guess",
						"the {C:attention}Hidden Word",
						"{C:inactive}(Resets at end of Ante)"
					},
					{
						"{C:white,X:mult}X#1#{} Mult for each",
						"{C:attention}Remaining{} guess",
						"{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
					}
				}
			},
			j_elle_tenna = {
				name = "It's TV Time!",
				text = {
					{
						"Before scoring, play a",
						"{C:attention,s:1.5,e:1}Physical Challenge",
						"{C:inactive}(Next up: {C:attention}#4#{C:inactive})"
					},
					{
						"Gains {C:white,X:mult}X#1#{} Mult if you survive",
						"then lose {C:white,X:mult}X#2#{} Mult per hit",
						"{C:inactive}(Currently {C:white,X:mult}X#3#{C:inactive} Mult)"
					}
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
					"to a random Joker",
					caption.."99... 100! This is too many tails~,,"
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
			j_elle_elle_title = {
				name = 'ellestuff.',
				text = {
					"{E:1}Hiii!{} Thank you for playing my mod.",
					"A lot of the Jokers are references to",
					"my own {C:attention}OCs{} and my {C:attention}friends{},",
					"but I hope you enjoy it regardless!",
					"{C:inactive,s:0.8}Click me for something very, very {C:elle,E:1,s:0.8}cool"
				},
				unlock = {
					"{E:1,s:1.3}?????"
				}
			},
		},
		Colour = {
			c_elle_jessblue = {
				name = "{E:mf_colour_title}Jess Blue",
				text = {
					"Converts a random card in",
					"hand to a {C:attention}Jess{} Card for every",
					"{C:attention}#4#{} round this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention,f:mf_emoji}#2#{C:inactive,f:mf_emoji}#3#{}]{C:inactive})",
				}
			},
			c_elle_ellepink = {
				name = "{E:mf_colour_title}Elle Pink",
				text = {
					"Converts a random card in",
					"hand to a {C:attention}Slime{} Card for every",
					"{C:attention}#4#{} round this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention,f:mf_emoji}#2#{C:inactive,f:mf_emoji}#3#{}]{C:inactive})",
				}
			},
		},
		Tarot = {
			c_elle_resident = {
				name = "Resident",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"cards into",
					"{C:attention}Slime Cards"
				}
			},
			c_elle_jess = {
				name = "The Jess",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"cards into",
					"{C:attention}Jess Cards"
				}
			}
		},
		Spectral = {
			c_elle_experiment = {
				name = "Experiment",
				text = {
					"Transfer the {C:attention}Edition",
					"from the selected {C:attention}Joker",
					"to up to {C:attention}#1#{} selected",
					"Cards in hand",
					"{s:0.8,C:inactive}(Incompatible with {s:0.8,C:attention}Negative{s:0.8,C:inactive})"
				}
			},
			c_elle_doppel = {
				name = "Doppelgänger",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"card into a",
					"{C:attention}Copycat Card"
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
			},
			m_elle_jess = {
				name = "Jess Card",
				text = {
					"Retrigger this card",
					"{C:attention}#1#{} time per every {C:attention}#2#",
					"scoring {C:attention}Jess{} cards"
				}
			},
			m_elle_copycat = {
				name = "Copycat Card",
				text = {
					"Copies {C:attention}Card",
					"to the right",
					"no rank or suit"
				}
			}
		},
		Other = {
			slime_upgr_j_elle_chloe = {
				name = 'Upgrade..?',
				text = {
					"Discard {C:attention}#1#{C:inactive}[#2#]",
					"{C:attention}face{} cards"
				}
			},
			slime_upgr_j_elle_furry = {
				name = 'Upgrade',
				text = {
					"Have {C:red}Sarah",
					"or {C:red}Cassie"
				}
			},
			slime_upgr_j_elle_feri = {
				name = 'Upgrade',
				text = {
					"Upgrade {C:attention}#1#{C:inactive}[#2#]{} cards",
					"with {C:attention}Fallen Angel",
					"present"
				}
			},
			slime_upgr_j_elle_sophie = {
				name = 'Upgrade',
				text = {
					"{C:attention}Release{} at least {C:attention}#1#{C:inactive}[#2#]",
					"rounds of Mult",
					"at once"
				}
			},
			slime_upgr_j_elle_sarah = {
				name = 'Upgrade..?',
				text = {
					"Make a {C:red}grave",
					"{C:red}mistake"
				}
			},
			slime_upgr_j_elle_p41 = {
				name = 'Upgrade',
				text = {
					"Trigger",
					"{C:attention}#1#{C:inactive}[#2#]{} times"
				}
			},
			slime_upgr_j_elle_drago = {
				name = 'Upgrade',
				text = {
					"Have {C:attention}#1#{C:inactive}[#2#]{} Wild cards",
					"with {C:attention}Cheshire{} present"
				}
			},
			slime_upgr_j_credit_card = {
				name = 'Upgrade',
				text = {
					"End {C:attention}#1#{C:inactive}[#2#]{} rounds",
					"at or below {C:red}-$#3#"
				}
			},
			
			elle_upgr_no_shop = {
				name = 'Upgrade Only',
				text = {
					"This Joker can only",
					"be obtained through",
					"{C:attention}Upgrading"
				}
			},
			
			elle_protected = {
				name = 'Protected',
				text = {
					"Instantly {C:red}lose{} the",
					"run when this",
					"card is {C:attention}changed{},",
					"{C:attention}sold{}, or {C:attention}destroyed"
				}
			},

			elle_crash_warning = {
				name = 'Crash Warning!',
				text = {
					"This card may {C:red}crash",
					"the game due to an",
					"incompatibility with:",
					"{C:attention}#1#"
				}
			},

			elle_marie_upgrade = {
				name = 'Slimeify',
				text = {
					"Pay {C:money}$#1#"
				}
			},

			elle_cameo = {
				name = 'Cameo',
				text = {
					"Character by",
					"{C:attention}#1#",
					"{C:inactive,s:0.7}#2#"
				}
			},

			elle_crossover = {
				name = 'Crossover',
				text = {
					"Character by",
					"{C:attention}#1#",
					"{C:inactive,s:0.7}#2#"
				}
			},

			ellemicrogame_rhythm = {
				name = 'Lightners Live',
				text = {
					"Hit the {C:attention}#1#{} and {C:attention}#2#{} keys",
					"to hit the notes",
					"at the right time"
				}
			}
		},
		Tag = {
			tag_elle_rebecca={
				name="Café Tag",
				text={
					"Restocks",
					"{C:attention}Rebecca{}'s Shop"
				}
			},
			tag_elle_spamton={
				name="[[BIG]] Tag",
				text={
					"Restocks the",
					"[[{V:1}BIG {V:2}SHOP{}]]"
				}
			}
		},
		Voucher = {
			v_elle_mixup = {
				name = "Mix-up",
				text={
					"{C:common}Common{}, {C:uncommon}Uncommon{}, and",
					"{C:rare}Rare{} Jokers are {C:attention}equally",
					"{C:attention}likely{} to appear"
				}
			},
			v_elle_breakthrough = {
				name = "Breakthrough",
				text={
					"{C:legendary}Legendary{} Jokers can",
					"appear in {C:attention}Shop"
				}
			}
		},
		Passives = {
			psv_elle_familiar = {
				name = "Familiar Face",
				description = {
					"{C:attention}Mall{} Jokers are debuffed"
				}
			}
		},
		Back={
			b_elle_tenna={
				name="{C:red}TV{} Deck",
				text={
					"{C:attention}X#1#{} base Blind size",
					"Play {C:attention}Physical Challenges",
					"for every {C:attention}#2#{} antes played",
					"at the start of Blinds",
					"{C:red}X#3#{} Blind size on hit",
					"{C:inactive}(Max {C:attention}#4#{C:inactive} per round)"
				}
			}
		},
		Blind = {
			bl_elle_final_episode = {
				name = "Final Episode",
				text = {
					"Defeat Tenna"
				},
			},
			-- Blindside stuff
			bl_elle_suggestion = {
				name = "Suggestion",
				text = {
					"Held blinds are burned",
					"and temporary The Queens",
					"are added to deck"
				},
			},
			bl_elle_chloe = {
				name = "Chloe",
				text = {
					"+20 Chips when",
					"discarding blinds"
				},
			}
		}
	},
	misc = {
		dictionary = {
			elle_joker_open = "OPEN",
			elle_joker_activate = "ACTIVE",
			
			elle_rebecca_title1 = "Rebecca's Store",
			elle_rebecca_title2 = "(Formerly Slime Café)",
			elle_rebecca_booster = "BOOSTER PACK",
			elle_rebecca_joker = "JOKERS",
			elle_rebecca_consumable = "CONSUMABLES",
			elle_rebecca_reroll = "Reroll All",
			elle_shop_restock = "Restocked!",
			
			elle_41_activate = "Yeah~!",
			elle_suggestion = "Forcefem!",
			elle_ourple_kill = "!!!",
			
			k_points = "Points"
		},
		achievement_names = {
			ach_elle_soretro = "So Retro",
			ach_elle_copycat = "Redundancy",
			ach_elle_lamp = "Familiar Bulb",
			ach_elle_puritan = "Puritans be damned",
			ach_elle_doublekill = "Double Kill",
			ach_elle_wordlelucky = "Lucky Guess"
		},
		achievement_descriptions = {
			ach_elle_soretro = "Toggle the limited palette shader",
			ach_elle_copycat = "Play 5 pointless Copycat cards",
			ach_elle_lamp = "Obtain a unique lamp",
			ach_elle_puritan = "Disable the \"Streamer Mode\", restoring the sprites to their original appearance",
			ach_elle_doublekill = "Upgrade Furry with both cards present",
			ach_elle_wordlelucky = "Win Wordle in 1 or 2 guesses"
		},
		challenge_names = {
			c_elle_cafe_frequent = "Café Frequent",
			c_elle_spamton = "[[Number 1 Rated]]",
			c_elle_shopless = "Shopless",
			c_elle_cobbled = "Cobbled",
			c_elle_pay2play = "Pay 2 Play"
		},
		v_text = {
			ch_c_elle_no_shop = { "Shop is {C:attention}skipped{} at end of round" },
			ch_c_elle_not_all = { "Instantly {C:attention}lose{} the run if initial scoring hand is all {C:attention}#1#s" },
			ch_c_elle_untested = { "{C:inactive}This challenge has not been tested and may be {C:red}impossible" },
			ch_c_elle_beat_credit = { "{C:inactive}This challenge was first beaten by {C:attention}#1#" },
		},
		labels = {
			elle_protected="Protected"
		}
	}
}

