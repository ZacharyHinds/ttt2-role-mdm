if SERVER then
  local function WriteNoiseTable(tbl)
    local json = util.TableToJSON(tbl)
    file.Write("ttt2_mdm_noises.txt", json)
  end
  util.AddNetworkString("ttt2_mdm_chatsend")

  local function RetrieveNoiseTable()
    local json = file.Read("ttt2_mdm_noises.txt")
    if not json then return false end
    return util.JSONToTable(json)
  end

  local function AddToNoiseTable(str)
    local tbl = RetrieveNoiseTable()
    tbl[#tbl + 1] = str
    WriteNoiseTable(tbl)
  end

  local function RemoveFromNoiseTable(str)
    local tbl = RetrieveNoiseTable()
    local didRemove = false
    for i = 1, #tbl do
      local noise = tbl[i]
      if noise == str then
        table.remove(tbl, i)
        didRemove = true
      end
    end
    WriteNoiseTable(tbl)
    return didRemove
  end

  local function ResetNoiseTable()
    local tbl = {
      "*hssss*",
      "%$$#@",
      "*ktch*"
    }
    WriteNoiseTable(tbl)
  end
  local random_noise = {}

  hook.Add("TTT2FinishedLoading", "TTT2MediumNoiseTableInitialize", function()
    if not file.Exists("ttt2_mdm_noises.txt", "DATA") then
      print("[TTT2 Medium Role] Creating data/ttt2_mdm_noises.txt")
      ResetNoiseTable()
    end
    random_noise = RetrieveNoiseTable() or {"error"}
    print("[TTT2 Medium Role] Retrieved data/ttt2_mdm_noises.txt adding the following noise words:")
    for i = 1, #random_noise do
      print("[TTT2 Medium Role] - " .. random_noise[i])
    end
  end)


  local function ScrambleString(str)
    local tbl = {}
    for i = 1, #str do
      table.insert(tbl, str:sub(i,i))
    end
    local out = ""
    repeat
      local r = math.random(#tbl)
      local chr = tbl[r]
      out = out .. chr
      table.remove(tbl, r)
    until #tbl <= 0
    return out
  end

  local function SplitString(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local tbl = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
      table.insert(tbl, str)
    end
    return tbl
  end

  local function ResetNoiseConcommand(ply, str, cmd, args, argStr)
    -- print("[TTT2 Medium Role] Noise table reset")
    ResetNoiseTable()
    random_noise = RetrieveNoiseTable()
  end

  local function PrintNoiseTable(ply, str, cmd, args, argStr)
    local tbl = RetrieveNoiseTable()
    local out = ""
    for i = 1, #tbl do
      if #out == 0 then
        out = tbl[i]
      else
        out = out .. ", " .. tbl[i]
      end
    end
    print(out)
  end

  concommand.Add("ttt2_mdm_reset_noise", ResetNoiseConcommand)
  concommand.Add("ttt2_mdm_print_noise", PrintNoiseTable)

  local function StringToTbl(str)
    local tbl = {}
    for i = 1, #str do
      table.insert(tbl, str:sub(i,i))
    end
    return tbl
  end

  local function TblToStr(tbl, spacer)
    if spacer == nil then
      spacer = ""
    end
    local str = ""
    for i = 1, #tbl do
      if #str == 0 then
        str = tbl[i]
      else
        str = str .. spacer .. tbl[i]
      end
    end
    return str
  end

  local function NoiseAddConcommand(ply, str, cmd, args, argStr)
    -- print("[TTT2 Medium Role] Noise Add Ran ")
    local inputstr = TblToStr(args)
    args = SplitString(inputstr, ",")
    for i = 1, #args do
      -- print("[TTT2 Medium Role] Adding")
      AddToNoiseTable(args[i])
    end
    random_noise = RetrieveNoiseTable()
  end
  concommand.Add("ttt2_mdm_add_noise", NoiseAddConcommand)

  local function NoiseRemoveConcommand(ply, str, cmd, args, argStr)
    -- print("[TTT2 Medium Role] Noise Remove Ran: " .. argStr)
    local inputstr = TblToStr(args)
    args = SplitString(inputstr, ",")
    for i = 1, #args do
      RemoveFromNoiseTable(args[i])
    end
    random_noise = RetrieveNoiseTable()
  end
  concommand.Add("ttt2_mdm_remove_noise", NoiseRemoveConcommand)

  local charset = {}  do -- [0-9a-zA-Z]
      for c = 48, 57  do table.insert(charset, string.char(c)) end
      for c = 65, 90  do table.insert(charset, string.char(c)) end
      for c = 97, 122 do table.insert(charset, string.char(c)) end
  end

  local function AddRndChar(str, num)
    if num == nil then
      num = math.random(#str)
    end
    local tmp = StringToTbl(str)
    for i = 1, num do
      table.insert(tmp, math.random(#tmp), charset[math.random(#charset)])
    end
    str = TblToStr(tmp)
    return str
  end

  local function DelRndChr(str, num)
    if num == nil then
      num = math.random(#str * 0.33)
    end
    local tmp = StringToTbl(str)
    for i = 1, num do
      table.remove(tmp, math.random(#tmp))
    end
    str = TblToStr(tmp)
    return str
  end

  local function NoisifyString(str, rnd, count)
    if rnd == nil then rnd = math.random(1,100) end
    if count == nil then count = 1 end
    local start_len = #str

    for i = 1, count do
      if rnd <= 33 and #str <= start_len * 2 then
        str = AddRndChar(str, math.random(math.Round(#str * 0.25), math.Round(#str * 0.75)))
      elseif rnd <= 66 and #str >= start_len * 0.5 then
        str = DelRndChr(str, math.random(1, math.Round(#str * 0.33)))
      elseif rnd <= 100 then
        str = ScrambleString(str)
      end
    end
    return str
  end

  local function CreateNoiseList()
    local tbl = random_noise
    local plys = player.GetAll()
    for i = 1, #plys do
      tbl[#tbl + 1] = plys[i]:Nick()
    end
    return tbl
  end

  local function ReplaceTblStrNoise(tbl, idx, noise_tbl)
    if idx == nil then
      idx = math.random(#tbl)
    end
    tbl[idx] = NoisifyString(noise_tbl[math.random(#noise_tbl)])
    return tbl
  end

  local function ShuffleTable(tbl)
    local tmp = {}
    repeat
      local rnd = math.random(#tbl)
      table.insert(tmp, tbl[rnd])
      table.remove(tbl, rnd)
    until #tbl <= 0
    return tmp
  end

  local function RandomNoiseMessage(msg)
    local sentence = SplitString(msg)
    if #sentence > 1 then
      for i = 1, #sentence do
        local str = sentence[i]
        local rnd = math.random(1,100)
        if rnd <= 60 then
          sentence[i] = NoisifyString(str)
        elseif rnd <= 85 then
          sentence = ReplaceTblStrNoise(sentence, i, CreateNoiseList(random_noise))
        end
      end
      if math.random(1,100) >= 45 then
        sentence = ShuffleTable(sentence)
      end
    elseif #sentence > 0 then
      local str = sentence[1]
      local rnd = math.random(1,100)
      if rnd <= 95 then
        sentence[1] = NoisifyString(str, nil, #str)
      elseif rnd == 100 then
        sentence = ReplaceTblStrNoise(sentence, 1, CreateNoiseList(random_noise))
      end
    end
    return TblToStr(sentence, " ")
  end

  local function SeanceChat(ply, msg, teamChat)
    print("[TTT2 Medium Role] Message Sent")
    if not ply:IsSpec() or ply:Alive() then return end
    print("[TTT2 Medium Role] Spectator Message Identified")
    local plys = util.GetAlivePlayers()
    local noise = RandomNoiseMessage(msg)
    print("[TTT2 Medium Role] Noisified chat: " .. noise)
    for i = 1, #plys do
      local mdm = plys[i]
      if mdm:GetSubRole() == ROLE_MEDIUM then
        net.Start("ttt2_mdm_chatsend")
        net.WriteString(noise)
        net.Send(mdm)
        print("[TTT2 Medium Role] Message sent to " .. mdm:Nick())
      end
    end
  end

  hook.Add("PlayerSay", "TTT2SeanceChat", SeanceChat)

end

if CLIENT then
  net.Receive("ttt2_mdm_chatsend", function()
    local mdm = LocalPlayer()
    local noise = net.ReadString()
    mdm:PrintMessage(HUD_PRINTTALK, LANG.GetParamTranslation("ttt2_mdm_spirit", {msg = noise})) -- "The spirit says 'msg'"
  end)
end
