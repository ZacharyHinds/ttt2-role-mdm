CreateConVar("ttt2_mdm_add_nicks", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should add player usernames to noise list?")
CreateConVar("ttt2_mdm_scramble_chance", "50", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for each word to get scrambled")
CreateConVar("ttt2_mdm_replace_chance", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for each word to get replaced")
CreateConVar("ttt2_mdm_shuffle_chance", "45", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance for sentence to get shuffled")

if SERVER then
  AddCSLuaFile()
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_mdm.vmt")
end

function ROLE:PreInitialize()
  self.color = Color(117, 212, 44, 255)

  self.abbr = "mdm"
  self.surviveBonus = 0
  self.scoreKillsMultiplier = 1
  self.scoreTeamKillsMultiplier = -4
  self.unknownTeam = true

  self.defaultEquipment = SPECIAL_EQUIPMENT
  self.defaultTeam = TEAM_INNOCENT

  self.conVarData = {
    pct = 0.17,
    maximum = 1,
    minPlayers = 6,
    togglable = true,
    random = 50
  }
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_INNOCENT)
end

if CLIENT then
  hook.Add("TTT2FinishedLoading", "mdm_devicon", function()
    AddTTT2AddonDev("76561198049910438")
  end)

  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeCheckBox({
      serverConvar = "ttt2_mdm_add_nicks",
      label = "label_ttt2_mdm_add_nicks"
    })

    form:MakeSlider({
      serverConvar = "ttt2_mdm_scramble_chance",
      label = "label_ttt2_mdm_scramble_chance",
      min = 0,
      max = 100,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_mdm_replace_chance",
      label = "label_ttt2_mdm_replace_chance",
      min = 0,
      max = 100,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_mdm_shuffle_chance",
      label = "label_ttt2_mdm_shuffle_chance",
      min = 0,
      max = 100,
      decimal = 0
    })
  end
end