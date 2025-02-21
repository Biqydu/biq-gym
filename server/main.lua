if Config.Framework == 'qbox' then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('biq-gym:server:buyGymPass', function()
    local src = source
    RemoveItem(src, 'money', Config.GymPassPrice)
    AddItem(src, Config.GymPass)
end)

-- lib.callback.register('biq-gym:server:getPlayerStats', function(source)
--   local player = GetPlayerCid(source)

--   if player then
--     if Config.Framework == 'qbox' then
--       local result = MySQL.query.await('SELECT stats FROM players WHERE citizenid = @citizenid', {['@citizenid'] = player})
--       if result[1] then
--         local statsString = result[1].stats
--         print("Raw stats found: " .. statsString)

--         local stats = json.decode(statsString)

--         if stats then
--           print("Parsed stats: " .. json.encode(stats))
--           return stats
--         else
--           print("Error parsing stats JSON.")
--           return nil
--         end
--       else
--         print("No stats found for player.")
--         return nil
--       end
--     elseif Config.Framework == 'qb' then
--       local result = MySQL.query.await('SELECT stats FROM players WHERE citizenid = @citizenid', {['@citizenid'] = player})
--       if result[1] then
--         local statsString = result[1].stats
--         print("Raw stats found: " .. statsString)

--         local stats = json.decode(statsString)

--         if stats then
--           print("Parsed stats: " .. json.encode(stats))
--           return stats
--         else
--           print("Error parsing stats JSON.")
--           return nil
--         end
--       else
--         print("No stats found for player.")
--         return nil
--       end
--     elseif Config.Framework == 'esx' then
--       local result = MySQL.query.await('SELECT stats FROM users WHERE identifier = @citizenid', {['@citizenid'] = player})
--       if result[1] then
--         local statsString = result[1].stats
--         print("Raw stats found: " .. statsString)

--         local stats = json.decode(statsString)

--         if stats then
--           print("Parsed stats: " .. json.encode(stats))
--           return stats
--         else
--           print("Error parsing stats JSON.")
--           return nil
--         end
--       else
--         print("No stats found for player.")
--         return nil
--       end
--     end
--   end
-- end)



AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
end)