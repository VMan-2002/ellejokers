
SMODS.Tag {
	key = "rebecca",
	atlas = "tag",
	pos = {x=0,y=0},
	in_pool = function(self, args)
		return next(SMODS.find_card("j_elle_rebecca"))
	end,
	apply = function(self, tag, context)
		if context.type == 'immediate' then
            tag:yep('Restocked!', G.C.MONEY, function()
                G.GAME.elle_rebecca.reset_on_open = true
                return true
            end)
            tag.triggered = true
        end
	end
}

