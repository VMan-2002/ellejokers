-- Start with eternal Marie and Riff-Raff, and no Jokers in shop.
SMODS.Challenge {
	key = "marie",
	loc_txt = {
		name = "Check-In"
	},
	rules = {
		custom = {
			{id = "no_shop_jokers"}
		},
		modifiers = {
			{id = "joker_slots", value = 6}
		}
	},
	jokers = {
		{id = "j_elle_marie", eternal = true, pinned = true},
		{id = "j_riff_raff", eternal = true, pinned = true}
	},
	restrictions = {
		banned_cards = {
			{id = 'c_judgement'},
			{id = 'c_wraith'},
			{id = "c_elle_parasite"},
			{id = 'c_soul'},
			{id = 'p_buffoon_normal_1', ids = {
				'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1'}}
		},
		banned_tags = {
			{id = 'tag_rare'},
			{id = 'tag_uncommon'},
			{id = 'tag_holo'},
			{id = 'tag_polychrome'},
			{id = 'tag_negative'},
			{id = 'tag_foil'},
			{id = 'tag_buffoon'}
		}
	}
}

-- All Slimed Cards
SMODS.Challenge {
	key = "slimed",
	loc_txt = {
		name = "Residency"
	},
	rules = {
            custom = {
            },
            modifiers = {
            }
        },
        jokers = {
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            cards = {{s='D',r='2',e='m_elle_slimed',},{s='D',r='3',e='m_elle_slimed',},{s='D',r='4',e='m_elle_slimed',},{s='D',r='5',e='m_elle_slimed',},{s='D',r='6',e='m_elle_slimed',},{s='D',r='7',e='m_elle_slimed',},{s='D',r='8',e='m_elle_slimed',},{s='D',r='9',e='m_elle_slimed',},{s='D',r='T',e='m_elle_slimed',},{s='D',r='J',e='m_elle_slimed',},{s='D',r='Q',e='m_elle_slimed',},{s='D',r='K',e='m_elle_slimed',},{s='D',r='A',e='m_elle_slimed',},{s='C',r='2',e='m_elle_slimed',},{s='C',r='3',e='m_elle_slimed',},{s='C',r='4',e='m_elle_slimed',},{s='C',r='5',e='m_elle_slimed',},{s='C',r='6',e='m_elle_slimed',},{s='C',r='7',e='m_elle_slimed',},{s='C',r='8',e='m_elle_slimed',},{s='C',r='9',e='m_elle_slimed',},{s='C',r='T',e='m_elle_slimed',},{s='C',r='J',e='m_elle_slimed',},{s='C',r='Q',e='m_elle_slimed',},{s='C',r='K',e='m_elle_slimed',},{s='C',r='A',e='m_elle_slimed',},{s='H',r='2',e='m_elle_slimed',},{s='H',r='3',e='m_elle_slimed',},{s='H',r='4',e='m_elle_slimed',},{s='H',r='5',e='m_elle_slimed',},{s='H',r='6',e='m_elle_slimed',},{s='H',r='7',e='m_elle_slimed',},{s='H',r='8',e='m_elle_slimed',},{s='H',r='9',e='m_elle_slimed',},{s='H',r='T',e='m_elle_slimed',},{s='H',r='J',e='m_elle_slimed',},{s='H',r='Q',e='m_elle_slimed',},{s='H',r='K',e='m_elle_slimed',},{s='H',r='A',e='m_elle_slimed',},{s='S',r='2',e='m_elle_slimed',},{s='S',r='3',e='m_elle_slimed',},{s='S',r='4',e='m_elle_slimed',},{s='S',r='5',e='m_elle_slimed',},{s='S',r='6',e='m_elle_slimed',},{s='S',r='7',e='m_elle_slimed',},{s='S',r='8',e='m_elle_slimed',},{s='S',r='9',e='m_elle_slimed',},{s='S',r='T',e='m_elle_slimed',},{s='S',r='J',e='m_elle_slimed',},{s='S',r='Q',e='m_elle_slimed',},{s='S',r='K',e='m_elle_slimed',},{s='S',r='A',e='m_elle_slimed',},},
            type = 'Challenge Deck'
        },
        restrictions = {
            banned_cards = {
                {id = 'c_magician'},
                {id = 'c_empress'},
                {id = 'c_heirophant'},
                {id = 'c_chariot'},
                {id = 'c_devil'},
                {id = 'c_tower'},
                {id = 'c_lovers'},
                {id = 'c_incantation'},
                {id = 'c_grim'},
                {id = 'c_familiar'},
                {id = 'c_elle_resident'},
                {id = 'p_standard_normal_1', ids = {
                    'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
                }},
                {id = 'j_marble'},
                {id = 'j_vampire'},
                {id = 'j_midas_mask'},
                {id = 'j_elle_jess'},
                {id = 'j_certificate'},
                {id = 'v_magic_trick'},
                {id = 'v_illusion'},
            },
            banned_tags = {
                {id = 'tag_standard'},
            },
            banned_other = {
            }
        }
}
