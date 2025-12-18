local bc = {}
if (Cryptid) then bc[#bc+1] = {id="c_cry_run"} end
SMODS.Challenge {
	key = "cafe_frequent",
	jokers = {{
			id = "j_elle_rebecca",
			eternal=true
	}},
	rules = {
		custom = {
			{id = "elle_no_shop"}
		},
		modifiers = {
			{id="joker_slots",value=6}
		}
	},
	restrictions = {
		banned_tags = {
			{id="tag_uncommon"},
			{id="tag_rare"},
			{id="tag_negative"},
			{id="tag_foil"},
			{id="tag_holo"},
			{id="tag_polychrome"},
			{id="tag_voucher"},
			{id="tag_coupon"},
			{id="tag_d_six"},
		},
		banned_cards = bc
	}
}