-- I copied a lot of this from the Cryptid code lmao
elle_bsky_count = 100 -- fallback amount
local succ, https = pcall(require, "SMODS.https")
local last_update_time = 0
local initial = true
elle_bsky_did = "did:plc:56kaelt4plcrtrztlqa3hfal" -- bsky did/handle to check
if not succ then
	sendErrorMessage("HTTP module could not be loaded. " .. tostring(https), "ellejokers.")
end

local function apply_follower_count(code, body, headers)
	if body then
		local count = string.match(body, '"followersCount"%s*:%s*(%d+)')
		elle_bsky_count = count or elle_bsky_count
	end
end
function elle_update_follower_count()
	if https and https.asyncRequest then
		if (os.time() - last_update_time >= 60) or initial then
			initial = false
			last_update_time = os.time()
			https.asyncRequest(
				"https://public.api.bsky.app/xrpc/app.bsky.actor.getProfile?actor=" .. elle_bsky_did,
				apply_follower_count
			)
		end
	end
end
elle_update_follower_count()

function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        elle_update_follower_count()
    end
end