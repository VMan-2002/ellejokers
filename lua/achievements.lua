SMODS.Achievement {
	key="soretro",
	bypass_all_unlocked = true,
	unlock_condition = function (self, args)
		if args and (args.type == "elle_toggle_palette") then
			return true
		end
	end
}

SMODS.Achievement {
	key="copycat",
	bypass_all_unlocked = true,
	unlock_condition = function (self, args)
		if args and (args.type == "elle_copycat_fail") then
			return true
		end
	end
}

function elle_achievement_mod_calc(self, context)
	if context.final_scoring_step then
		-- Copycat check
		local copycat_ach = 0
		for i, v in ipairs(G.play.cards) do
			copycat_ach = copycat_ach + ((v.config.center.key == "m_elle_copycat" and ellejokers.get_copycat_target(v) == nil) and 1 or 0)
		end
		if copycat_ach >= 5 then
			G.E_MANAGER:add_event(Event({ func = function()
				check_for_unlock({type = "elle_copycat_fail"})
				return true
			end}))
		end
	end
end