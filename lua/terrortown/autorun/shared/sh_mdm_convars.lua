CreateConVar("ttt2_mdm_add_nicks", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should add player usernames to noise list?")

if CLIENT then
  hook.Add("TTT2FinishedLoading", "mdm_devicon", function()
    AddTTT2AddonDev("76561198049910438")
  end)
end

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicMdmCVars", function(tbl)
  tbl[ROLE_MEDIUM] = tbl[ROLE_MEDIUM] or {}

  table.insert(tbl[ROLE_MEDIUM], {
    cvar = "ttt2_mdm_add_nicks",
    checkbox = true,
    desc = "ttt2_mdm_add_nicks (def. 1)"
  })
end)
