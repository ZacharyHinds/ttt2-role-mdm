CreateConVar("ttt2_mdm_add_nicks", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should add player usernames to noise list?")
CreateConVar("ttt2_mdm_scramble_chance", "50", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for each word to get scrambled")
CreateConVar("ttt2_mdm_replace_chance", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for each word to get replaced")
CreateConVar("ttt2_mdm_shuffle_chance", "45", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for sentence to get shuffled")

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

  table.insert(tbl[ROLE_MEDIUM], {
    cvar = "ttt2_mdm_scramble_chance",
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_mdm_scramble_chance (def. 50)"
  })

  table.insert(tbl[ROLE_MEDIUM], {
    cvar = "ttt2_mdm_replace_chance",
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_mdm_replace_chance (def. 15)"
  })

  table.insert(tbl[ROLE_MEDIUM], {
    cvar = "ttt2_mdm_shuffle_chance",
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_mdm_shuffle_chance (def. 45)"
  })
end)
