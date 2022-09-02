if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()

elseif Config.Framework == 'ESX' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    -- Without a framework, items cannot be given.
    -- You can add your own other framework here
end


RegisterServerEvent('npcmissions:server:rewardPlayer', function(kills)
    local src = source
    local moneyPerKill = 250
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddMoney('cash', kills * moneyPerKill)
    elseif Config.Framework == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addMoney(kills * moneyPerKill)
    else
        -- Add your own code here if you are not using ESX or QBCore
    end
end)