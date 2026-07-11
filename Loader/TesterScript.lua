local placeScripts = {
    [2753915549]      = "f03cdfd981549bad3eacd0189801c6b9",
    [85211729168715]  = "f03cdfd981549bad3eacd0189801c6b9",
    [4442272183]      = "f03cdfd981549bad3eacd0189801c6b9", 
    [79091703265657]  = "f03cdfd981549bad3eacd0189801c6b9", 
    [7449423635]      = "f03cdfd981549bad3eacd0189801c6b9",
    [100117331123089] = "f03cdfd981549bad3eacd0189801c6b9", 
}

local scriptId = placeScripts[game.PlaceId]

if not scriptId then
    local Players = game:GetService("Players")
    Players.LocalPlayer:Kick("\n❌  MidNight Hub\n\nEste jogo não é suportado.\nAcesse nosso Discord:\ndiscord.gg/Wkj77kdgHS")
    return
end

local luarmor = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua", true))()
luarmor.script_id = scriptId
luarmor.load_script()