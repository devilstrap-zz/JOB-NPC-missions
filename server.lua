local QBCore = exports['qb-core']:GetCoreObject()
local active = false
local playerSrcs = {}
local allPlayers = {}
local alivePeds = {}
local killedPedsCounting = {}
local playerKills = {}
local allPedsDead = false

-- FUNCTIONS 
    function TriggerForClients(list, event, args)
        for i = 1, #list do
            if args then
                TriggerClientEvent(event, list[i], args)
            else
                TriggerClientEvent(event, list[i])
            end
        end
    end

    function GetRandomClient()
        return playerSrcs[math.random(1, #playerSrcs)]
    end

    function RemoveAllPeds()
        for i = 1, #alivePeds do
            local ped = NetworkGetEntityFromNetworkId(alivePeds[i])
            DeleteEntity(ped)
            -- table.remove(alivePeds, i)
        end
        alivePeds = {}
    end

    function CountKills()
        for i = 1, #playerSrcs do
            local item = {
                source = playerSrcs[i],
                kills = 0
            }
            table.insert(playerKills, item)
        end
        for i = 1, #killedPedsCounting do
            for j = 1, #playerKills do
                if GetPlayerPed(tostring(playerKills[j].source)) == killedPedsCounting[i] then
                    playerKills[j].kills = playerKills[j].kills + 1
                end
            end
        end
        for i = 1, #playerKills do
            TriggerClientEvent('npcmissions:client:gotKills', tonumber(playerKills[i].source), tonumber(playerKills[i].kills))
        end 

    end
--

-- GENERIC EVENT HANDLERS
    AddEventHandler("playerDropped", function()
        local src = source
        for i = 1, #playerSrcs do
            if playerSrcs[i] == src then
                table.remove(playerSrcs, i)
            end
        end
        for i = 1, #allPlayers do
            if allPlayers[i] == src then
                table.remove(allPlayers, i)
            end
        end
    end)

    AddEventHandler('onResourceStop', function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
          return
        end
        RemoveAllPeds()
    end)

    RegisterNetEvent('npcmissions:server:OptOut', function()
        local src = source
        for i = 1, #playerSrcs do
            if playerSrcs[i] == src then
                table.insert(allPlayers, playerSrcs[i])
                table.remove(playerSrcs, i)
            end
        end
    end)
    
    RegisterNetEvent('npcmissions:server:OptIn', function()
        local src = source
        table.insert(playerSrcs, src)
        for i = 1, #allPlayers do
            if allPlayers[i] == src then
                table.remove(allPlayers, i)
            end
        end
    end)
--

-- MISSION EVENT HANDLERS
    RegisterNetEvent('npcmissions:server:SetupSurvival', function(mission)
        active = true
        Citizen.CreateThread(function()
            for _,id in pairs(GetPlayers()) do
                table.insert(allPlayers, tonumber(id))
            end
            -- Notify all players about mission to start and allow opt in
            TriggerClientEvent('npcmissions:client:PromptOptIn', -1, mission.name)
            Wait(Config.OptInTime * 1000)
            TriggerClientEvent('npcmissions:client:OptInOver', -1)
            TriggerForClients(playerSrcs, 'npcmissions:client:SetupSurvival', mission)
            Wait(Config.WaitTime * 1000)
            TriggerEvent(mission.begin, mission, 1)
            TriggerForClients(allPlayers, 'npcmissions:client:KeepOutZone', mission)
            return
        end)
    end)

    RegisterNetEvent('npcmissions:server:BeginGenericSurvival', function(mission, round)
        if mission['rounds'][tostring(round)] and #playerSrcs > 0 then
            -- print("starting round " .. round)
            local eNum = {}
            local enemies = mission['rounds'][tostring(round)]['enemies']
            for k in pairs(enemies) do table.insert(eNum, tonumber(k)) end
            table.sort(eNum)
            for _,i in pairs(eNum) do
                local ped = CreatePed(26, GetHashKey(enemies[tostring(i)].model), enemies[tostring(i)].coords, 0.0, true, true)
                -- print("spawning enemy " .. i)
                GiveWeaponToPed(ped, enemies[tostring(i)].weapon, tonumber(enemies[tostring(i)].ammo), true, true)
                local networkId = NetworkGetNetworkIdFromEntity(ped)
                TriggerForClients(playerSrcs, 'npcmissions:client:SetRelationshipGroup', {id = networkId, group = `MISSION2`})
                alivePeds[#alivePeds + 1] = networkId
                local randomPlayer = GetRandomClient()
                TaskCombatPed(ped, GetPlayerPed(randomPlayer), 0, 16)
                Citizen.CreateThread(function()
                    while GetPedSourceOfDeath(ped) == 0 and #playerSrcs > 0 do
                        allPedsDead = false
                        Wait(5000)
                    end
                    -- track who killed this npc
                    table.insert(killedPedsCounting, GetPedSourceOfDeath(ped))
                    if #playerSrcs < 1 then
                        RemoveAllPeds()
                    end
                    allPedsDead = true
                    for j = 1, #alivePeds do
                        if alivePeds[j] == networkId then
                            table.remove(alivePeds, j)
                        end
                    end

                    return
                end)
            end
            Citizen.CreateThread(function()
                while #alivePeds > 0 do
                    Wait(5000)
                end
                -- all peds dead, move to next round
                -- TODO: catch if all players are dead, end the game
                local r = round + 1
                print("moving to next round, all are dead")
                TriggerEvent(mission.begin, mission, r)
                return
            end)
        elseif #playerSrcs > 0 then
            -- win
            print("players won")
            RemoveAllPeds()
            CountKills()
            Wait(1000)
            TriggerClientEvent('npcmissions:client:SetEventOver', -1)
            active = false
            playerSrcs = {}
        else
            -- lost
            -- TODO: create game end notification
            print("lost the game")
            RemoveAllPeds()
            Wait(1000)
            TriggerClientEvent('npcmissions:client:SetEventOver', -1)
            active = false
        end
    end)
--

-- CALLBACKS
    RegisterServerCallback {
        eventName = 'npcmissions:server:IsAnyActive',
        eventCallback = function(source, ...)
            return active
        end
    }
--
