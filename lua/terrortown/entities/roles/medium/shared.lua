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
