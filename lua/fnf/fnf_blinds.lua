SMODS.Atlas{
	key = "fnf_blindchips",
	path = "fnf_blindchips.png",
	px = 34,
	py = 34,
	frames = 21,
	atlas_table = "ANIMATION_ATLAS"
}

local photochadfunkin = photochadfunkin

local bl_microphone = SMODS.Blind{
	key = "microphone",
	loc_txt = {
		name = "The Microphone",
		text = {"Must play FNF game","before playing this blind","(X1.2 score requirement per miss)","(click blind chip)"}
	},
	atlas = "fnf_blindchips",
	mult = 1,
	pos = {x = 0, y = 0},
	boss = {min = 3, max = 39},
	boss_colour = HEX('04A408'),
	debuff_hand = function(self)
		return not G.GAME.blind.photochadfunkin_completed
	end,
	disable = function(self)
		G.GAME.blind.photochadfunkin_completed = true
		G.GAME.blind.chips = G.GAME.blind.chips * (2 / self.mult)
		G.GAME.blind.chips = G.GAME.blind.chips * (2 / self.mult)
	end
}

local bl_microphone_showdown = SMODS.Blind{
	key = "microphone_showdown",
	loc_txt = {
		name = "Zoinks",
		text = {"Must play 9key FNF game","before playing this blind","(click blind chip)"}
	},
	atlas = "fnf_blindchips",
	mult = 2,
	pos = {x = 0, y = 0},
	boss = {showdown = true},
	boss_colour = HEX('04A408'),
	debuff_hand = bl_microphone.debuff_hand,
	disable = bl_microphone.disable
}

local bl_microphone_showdown_mania = SMODS.Blind{
	key = "microphone_showdown_mania",
	loc_txt = {
		name = "Maniac",
		text = {"Must play mania FNF game","before playing this blind","(click blind chip)"}
	},
	atlas = "fnf_blindchips",
	mult = 2,
	pos = {x = 0, y = 0},
	boss = {showdown = true},
	boss_colour = HEX('04A408'),
	debuff_hand = bl_microphone.debuff_hand,
	disable = bl_microphone.disable
}

local bclick = Blind.click
function Blind.click(self, ...) 
	if photochadfunkin.accepted_blinds[self.name] and not G.GAME.blind.photochadfunkin_completed then
		return photochadfunkin:options(self)
	end
	bclick(self, ...)
end