
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local QBCore = exports['qb-core']:GetCoreObject()
local optIn = false
local radiusBlip = nil
local markerBlip = nil
local activeEvent = false
local currentLocation = nil
local currentName = nil
local currentEvent = nil
local currentExit = nil

local SandySurvival = {
    location = vector3(1701.22, 3291.66, 38.15),
    name = 'Survival Mission',
    begin = 'npcmissions:server:BeginGenericSurvival',
    rounds = {
        ['1'] = {
            ['enemies'] = {
                ['1'] = {
                    coords = vector3(1693.27, 3333.34, 41.5),
                    weapon = `WEAPON_KNIFE`,
                    ammo = 1,
                    model = 's_m_m_movalien_01'
                },
                ['2'] = {
                    coords = vector3(1628.13, 3295.63, 39.69),
                    weapon = `WEAPON_MACHETE`,
                    ammo = 1,
                    model = 's_m_m_movalien_01'
                }
            }
        },
        ['2'] = {
            ['enemies'] = {
                ['1'] = {
                    coords = vector3(1628.33, 3295.5, 39.7),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['2'] = {
                    coords = vector3(1677.96, 3356.95, 40.2),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['3'] = {
                    coords = vector3(1772.78, 3348.01, 40.65),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['4'] = {
                    coords = vector3(1788.14, 3315.43, 41.51),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                }
            }
        },
        ['3'] = {
            ['enemies'] = {
                ['1'] = {
                    coords = vector3(1618.17, 3359.34, 38.79),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['2'] = {
                    coords = vector3(1619.0, 3360.98, 38.74),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['3'] = {
                    coords = vector3(1734.54, 3408.96, 37.58),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['4'] = {
                    coords = vector3(1731.2, 3413.06, 37.39),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['5'] = {
                    coords = vector3(1733.34, 3413.66, 37.11),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['6'] = {
                    coords = vector3(1779.01, 3321.17, 41.38),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['7'] = {
                    coords = vector3(1777.96, 3317.43, 41.39),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['8'] = {
                    coords = vector3(1788.14, 3315.43, 41.51),
                    weapon = `WEAPON_PUMPSHOTGUN`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                }
            }
        },
        ['4'] = {
            ['enemies'] = {
                ['1'] = {
                    coords = vector3(1597.25, 3252.27, 41.08),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['2'] = {
                    coords = vector3(1597.38, 3250.68, 41.5),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['3'] = {
                    coords = vector3(1596.16, 3251.24, 41.33),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['4'] = {
                    coords = vector3(1762.96, 3169.65, 43.51),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['5'] = {
                    coords = vector3(1764.1, 3169.54, 43.62),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['6'] = {
                    coords = vector3(1762.56, 3167.9, 43.6),
                    weapon = `WEAPON_PUMPSHOTGUN`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['7'] = {
                    coords = vector3(1812.76, 3287.94, 43.12),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['8'] = {
                    coords = vector3(1813.59, 3288.76, 43.05),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['9'] = {
                    coords = vector3(1814.29, 3287.27, 43.12),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['10'] = {
                    coords = vector3(1813.18, 3286.4, 43.21),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                }
            }
        },
        ['5'] = {
            ['enemies'] = {
                ['1'] = {
                    coords = vector3(1597.25, 3252.27, 41.08),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['2'] = {
                    coords = vector3(1597.38, 3250.68, 41.5),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['3'] = {
                    coords = vector3(1596.16, 3251.24, 41.33),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['4'] = {
                    coords = vector3(1762.96, 3169.65, 43.51),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['5'] = {
                    coords = vector3(1764.1, 3169.54, 43.62),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['6'] = {
                    coords = vector3(1762.56, 3167.9, 43.6),
                    weapon = `WEAPON_PUMPSHOTGUN`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['7'] = {
                    coords = vector3(1812.76, 3287.94, 43.12),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['8'] = {
                    coords = vector3(1813.59, 3288.76, 43.05),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['9'] = {
                    coords = vector3(1814.29, 3287.27, 43.12),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['10'] = {
                    coords = vector3(1813.18, 3286.4, 43.21),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['11'] = {
                    coords = vector3(1597.25, 3252.27, 41.08),
                    weapon = `WEAPON_POOLCUE`,
                    ammo = 1,
                    model = 's_m_m_movalien_01'
                },
                ['12'] = {
                    coords = vector3(1597.38, 3250.68, 41.5),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['13'] = {
                    coords = vector3(1596.16, 3251.24, 41.33),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['14'] = {
                    coords = vector3(1762.96, 3169.65, 43.51),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['15'] = {
                    coords = vector3(1764.1, 3169.54, 43.62),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['16'] = {
                    coords = vector3(1762.56, 3167.9, 43.6),
                    weapon = `WEAPON_PUMPSHOTGUN`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['17'] = {
                    coords = vector3(1812.76, 3287.94, 43.12),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['18'] = {
                    coords = vector3(1813.59, 3288.76, 43.05),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['19'] = {
                    coords = vector3(1814.29, 3287.27, 43.12),
                    weapon = `WEAPON_PISTOL`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                },
                ['20'] = {
                    coords = vector3(1813.18, 3286.4, 43.21),
                    weapon = `WEAPON_CARBINERIFLE`,
                    ammo = 50,
                    model = 's_m_m_movalien_01'
                }
            }
        }
    },
    exit = vector3(1656.54, 3240.71, 40.57),
}


-- BASE FUNCTIONS
    function loadmodel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(10)
        end
    end

    function loaddict(dict)
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Wait(10)
        end
    end

    function DrawText3Ds(x, y, z, text)
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end

    function showHelpNotification(msg)
        BeginTextCommandDisplayHelp("STRING")
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandDisplayHelp(0, 0, 1, -1)
    end

    local function drawTxt(text,font,x,y,scale,r,g,b,a)
        SetTextFont(font)
        SetTextScale(scale,scale)
        SetTextColour(r,g,b,a)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x,y)
    end

    function CheckPlayerDeath()
        Citizen.CreateThread(function()
            local ped = PlayerPedId()
            while true do
                if IsEntityDead(ped) then
                    TriggerEvent('npcmissions:client:OptOut')
                    TriggerServerEvent('npcmissions:server:OptOut')
                    Wait(5000)
                    TriggerServerEvent(Config.HealOne, false)
                    TriggerServerEvent(Config.HealTwo, false)
                    TriggerEvent(Config.ClientReviveFunction)
                    SetEntityCoords(ped, currentExit)

                    return
                end
                Wait(0)
            end
        end)
    end
-- 

-- GENERIC NET EVENTS
    RegisterNetEvent('npcmissions:openMenu', function()
        TriggerServerCallback {
            eventName = 'npcmissions:server:IsAnyActive',
            args = {},
            callback = function(result)
                if result == true then
                    -- TODO: tell the user that something is already active
                else
                    SetNuiFocus(true, true)
                    Wait(100)
                    SendNUIMessage({
                        type = "openMenu"
                    })
                end
            end
        }
    end)

    RegisterNetEvent('npcmissions:client:OptInOver', function()
        optIn = false
    end)

    RegisterNetEvent('npcmissions:client:OptOut', function()
        -- showHelpNotification('You have been removed from the ' .. currentName)
        if radiusBlip then
            RemoveBlip(radiusBlip)
        end
        if markerBlip then
            RemoveBlip(markerBlip)
        end
        currentEvent = nil
        currentName = nil
        currentLocation = nil
    end)

    RegisterNetEvent('npcmissions:client:PromptOptIn', function(text)
        SetNuiFocus(false, false)
        Wait(100)
        SendNUIMessage({
            type = "notif",
            text = "A " .. text .. " is about to begin.\n Press <kbd>" .. Config.KeyToJoin .. "</kbd> to join",
            time = (Config.OptInTime * 1000)
        })
        optIn = true
        Citizen.CreateThread(function()
            while optIn do
                -- showHelpNotification('A ' .. text .. ' is about to begin. \nPress ~INPUT_SNIPER_ZOOM~ to join')
                Wait(5)
                if IsControlJustPressed(0, Config.KeyNumber) then
                    TriggerServerEvent('npcmissions:server:OptIn')
                    SetNuiFocus(false, false)
                    Wait(100)
                    SendNUIMessage({
                        type = "unnotif"
                    })
                    optIn = false
                end
            end
        end)
    end)

    RegisterNetEvent('npcmissions:client:SetRelationshipGroup', function(args)
        Wait(1000)
        local ped = NetworkGetEntityFromNetworkId(args.id)
        Wait(250)
        if not DoesEntityExist(ped) then
            return
        end
        local blip = AddBlipForEntity(ped)
        SetBlipAsFriendly(blip, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedRelationshipGroupHash(ped, args.group)
        Citizen.CreateThread(function()
            while not IsEntityDead(ped) do
                Wait(5000)
            end
            RemoveBlip(blip)
            return
        end)
    end)

    RegisterNetEvent('npcmissions:client:SetEventOver', function()
        activeEvent = false
        if radiusBlip then
            RemoveBlip(radiusBlip)
        end
        if markerBlip then
            RemoveBlip(markerBlip)
        end
        currentEvent = nil
        currentName = nil
        currentLocation = nil
    end)

    RegisterNetEvent('npcmissions:client:IsInZone', function()
        local coords = GetEntityCoords(PlayerPedId())
        if #(coords - currentLocation) > 100 then
            TriggerEvent('npcmissions:client:OptOut')
            TriggerServerEvent('npcmissions:server:OptOut')
        else
            SetPedRelationshipGroupHash(PlayerPedId(), `MISSION3`)
            SetRelationshipBetweenGroups(5, `MISSION2`, `MISSION3`)
            SetRelationshipBetweenGroups(0, `MISSION2`, `MISSION2`)
            CheckPlayerDeath()
        end
    end)

    RegisterNetEvent('npcmissions:client:KeepOutZone', function(mission)
        currentLocation = mission.location
        currentName = SandySurvival.name
        radiusBlip = AddBlipForRadius(currentLocation, 100.0)
        SetBlipColour(radiusBlip, 59)
        SetBlipRotation(radiusBlip, 0)
        SetBlipAlpha(radiusBlip, 67)
        markerBlip = AddBlipForCoord(currentLocation)
        SetBlipSprite (markerBlip, 564)
        SetBlipDisplay(markerBlip, 4)
        SetBlipScale  (markerBlip, 0.7)
        SetBlipColour(markerBlip, 1)
        SetBlipAsShortRange(markerBlip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(currentName)
        EndTextCommandSetBlipName(markerBlip)
        if Config.KeepOutPlayers then
            Citizen.CreateThread(function()
                activeEvent = true
                local ped = PlayerPedId()
                local zone = mission.location
                while activeEvent do
                    local coords = GetEntityCoords(ped)
                    if #(zone - coords) < 100 then
                        local vel = coords - zone
                        local mag = math.sqrt((vel.x)^2 + (vel.y)^2 + (vel.z)^2)
                        vel = vector3(vel.x / mag, vel.y / mag, vel.z / mag)
                        local dist = math.sqrt((coords.x - zone.x)^2 + (coords.y - zone.y)^2 + (coords.z - zone.z)^2)
                        dist = 100 - dist
                        if dist < 10 then dist = 10 end
                        -- SetPedToRagdoll(ped, 1000, 2000, 0, 0, 0, 0)
                        SetEntityVelocity(ped, vel*dist)
                    end
                    Wait(2000)
                end
            end)
        end
    end)

    RegisterNetEvent('npcmissions:client:gotKills', function(kills)
        SetNuiFocus(false, false)
        Wait(100)
        SendNUIMessage({
            type = "notif",
            text = "Event Over.\n You got " .. kills .. " kills",
            time = 5000
        })
        TriggerServerEvent('npcmissions:server:rewardPlayer', kills)
    end)
-- 

-- MISSION SPECIFIC NET EVENTS
    RegisterNetEvent('npcmissions:client:SetupSurvival', function()
        currentLocation = SandySurvival.location
        currentName = SandySurvival.name
        currentEvent = SandySurvival.begin
        currentExit = SandySurvival.exit
        radiusBlip = AddBlipForRadius(currentLocation, 100.0)
        SetBlipColour(radiusBlip, 59)
        SetBlipRotation(radiusBlip, 0)
        SetBlipAlpha(radiusBlip, 67)
        markerBlip = AddBlipForCoord(currentLocation)
        SetBlipSprite (markerBlip, 564)
        SetBlipDisplay(markerBlip, 4)
        SetBlipScale  (markerBlip, 0.7)
        SetBlipColour(markerBlip, 1)
        SetBlipAsShortRange(markerBlip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(currentName)
        EndTextCommandSetBlipName(markerBlip)
        showHelpNotification('A marker has been added to your map. Get to the zone quickly.')

        Citizen.CreateThread(function()
            local gameTimer = GetGameTimer()
            while true do
                if GetGameTimer() < gameTimer + tonumber(1000 * Config.WaitTime) then
                    local secondsLeft = GetGameTimer() - gameTimer
                    drawTxt('Time Remaining Until Survival Begins: '..math.ceil(Config.WaitTime - secondsLeft / 1000), 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
                else
                    TriggerEvent('npcmissions:client:IsInZone')
                    break
                end
                Wait(0)
            end
        end)
    end)
    
--


-- NUI CALLBACKS

    RegisterNUICallback("CloseMenu", function (data, callback)
        SetNuiFocus(false, false)
        callback("ok")
    end)

    RegisterNUICallback("ChooseSurvival", function (data, callback)
        SetNuiFocus(false, false)
        callback("ok")
        TriggerServerEvent('npcmissions:server:SetupSurvival', SandySurvival)
        -- TriggerEvent("sawu_hookers:ChosenHooker", "s_f_y_hooker_01") -- Cathrine
    end)
-- 

-- THREADS

    Citizen.CreateThread(function ()
        while true do
            Wait(5)
            local coords, letSleep  = GetEntityCoords(PlayerPedId()), true
            for k,v in pairs(Config.Zones) do
                if #(v.Pos - coords) < 3.0 and v.name == 'Agent' then
                    letSleep = false
                    DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 1, "~b~[E]~w~ to select a mission")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerEvent("npcmissions:openMenu")
                    end
                end
            end
            if letSleep then
                Wait(1000)
            end
        end
    end)

    Citizen.CreateThread(function()
        for _,v in pairs(Config.Zones) do
            loadmodel(v.model)
            loaddict("mini@strip_club@idles@bouncer@base")

            missionselect =  CreatePed(1, v.model, v.Pos.x, v.Pos.y, v.Pos.z, v.heading, false, true)
            FreezeEntityPosition(missionselect, true)
            SetEntityInvincible(missionselect, true)
            SetBlockingOfNonTemporaryEvents(missionselect, true)
            TaskPlayAnim(missionselect,"mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end
    end)
--
