Config = {}

Config.Zones = {
    ["Agent"] = {
        Pos = vector3(1701.16, 3289.97, 52.84),
        name = "Agent",
        heading = 0.0,
        model = "csb_mp_agent14"
    },
}

Config.Framework = 'QBCore' -- {QBCore, ESX, Standalone}

Config.KeyToJoin = '`' -- this is the display
Config.KeyNumber = 243 -- https://docs.fivem.net/docs/game-references/controls/

Config.OptInTime = 10 -- seconds
Config.WaitTime = 10

Config.ClientReviveFunction = 'hospital:client:Revive'
Config.HealOne = 'hospital:server:SetLaststandStatus'
Config.HealTwo = 'hospital:server:SetDeathStatus'


 -- tp_ambulancejob:revive
 -- esx_basicneeds:healPlayer

Config.KeepOutPlayers = true