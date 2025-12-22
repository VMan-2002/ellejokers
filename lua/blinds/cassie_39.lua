SMODS.Blind {
	key = "cassie",
	atlas = "blinds",
	dollars = 0, 
	mult = 4, 
	phases = 3,
	pos = { x = 0, y = 0 },
	in_pool = function(self) return false end,
	ignore_showdown_check = true,
	boss_colour = HEX("538a68"),
	phase_refresh = true,
	boss = {showdown = true, min = 10, max = 10},
	vars = {}, 
	passives = {
		"psv_elle_familiar"
	}
}