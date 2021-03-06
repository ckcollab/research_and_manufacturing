---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Комерад.
--- DateTime: 5/27/2018 10:31 AM
---

--function GM:PlayerSpawn(ply)
--    -- Some spawns may be tilted
--    --ply:ResetViewRoll()
--
--    -- Clear out stuff like whether we ordered guns or what bomb code we used
--    --ply:ResetRoundFlags()
--
--    -- latejoiner, send him some info
--    --if GetRoundState() == ROUND_ACTIVE then
--    --   SendRoundState(GetRoundState(), ply)
--    --end
--
--    --ply.spawn_nick = ply:Nick()
--    --ply.has_spawned = true
--
--    -- let the client do things on spawn
--    --net.Start("TTT_PlayerSpawned")
--    --   net.WriteBit(ply:IsSpec())
--    --net.Send(ply)
--
--    if ply:IsSpec() then
--       ply:StripAll()
--       ply:Spectate(OBS_MODE_ROAMING)
--       return
--    end
--    --
--    ply:UnSpectate()
--    --
--    -- ye olde hooks
--    --hook.Call("PlayerLoadout", GAMEMODE, ply)
--    hook.Call("PlayerSetModel", GAMEMODE, ply)
--    --hook.Call("TTTPlayerSetColor", GAMEMODE, ply)
--    --
--    ply:SetupHands()
--
--    --SCORE:HandleSpawn(ply)
--    ply:Give("rm_pistol", false)
--    ply:GiveAmmo( 125, 3, false )
--end

--[[---------------------------------------------------------
	Name: gamemode:PlayerSpawnAsSpectator()
	Desc: Player spawns as a spectator
-----------------------------------------------------------]]
function GM:PlayerSpawnAsSpectator( pl )

	pl:StripWeapons()

	if ( pl:Team() == TEAM_UNASSIGNED ) then

		pl:Spectate( OBS_MODE_FIXED )
		return

	end

	pl:SetTeam( TEAM_SPECTATOR )
	pl:Spectate( OBS_MODE_ROAMING )

end

--[[---------------------------------------------------------
	Name: gamemode:PlayerSpawn()
	Desc: Called when a player spawns
-----------------------------------------------------------]]
function GM:PlayerSpawn( pl )

	--
	-- If the player doesn't have a team in a TeamBased game
	-- then spawn him as a spectator
	--
	if ( self.TeamBased and ( pl:Team() == TEAM_SPECTATOR or pl:Team() == TEAM_UNASSIGNED ) ) then

		self:PlayerSpawnAsSpectator( pl )
		return

	end

	-- Stop observer mode
	pl:UnSpectate()

	pl:SetupHands()

	--player_manager.OnPlayerSpawn( pl )
	--player_manager.RunClass( pl, "Spawn" )

	-- Call item loadout function
	hook.Call( "PlayerLoadout", GAMEMODE, pl )
    pl:Give("rm_pistol", false)
    pl:GiveAmmo( 125, 3, false )

	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )

end

function GM:PlayerSetModel(ply)
   local mdl = GAMEMODE.playermodel or "models/player/phoenix.mdl"
   util.PrecacheModel(mdl)
   ply:SetModel(mdl)

   -- Always clear color state, may later be changed in TTTPlayerSetColor
   ply:SetColor(COLOR_WHITE)
end