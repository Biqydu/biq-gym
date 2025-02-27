if Config.Framework == 'qbox' then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('biq-gym:server:buyGymPass', function()
  local src = source
  local playerPed = GetPlayerPed(src)
  local playerCoords = GetEntityCoords(playerPed)
  
  local distance = #(playerCoords - Config.Seller.coords.xyz)

  if distance < 6 then 
    if HasItem(src, 'money', Config.GymPassPrice) then
      TakeMoney(src, Config.GymPassPrice, locale('gym_pass'))
      AddItem(src, Config.GymPass)
  end
  else
      CheaterDetected(src)
  end
end)