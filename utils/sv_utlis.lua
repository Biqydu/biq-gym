if Config.Framework == 'qb' then 
  QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
  ESX = exports['es_extended']:getSharedObject()
end

---@param src number # player source
---@param title string # noti title can be empty string for qb
---@param desc string # noti desc
---@param type string # success or error
---@param duration number # Length of noti
function Notify(src, title, desc, type, duration)
  if Config.Notification == 'ox' then
    TriggerClientEvent('ox_lib:notify', src, {
      title = title,
      description = desc,
      type = type or 'info',
      duration = duration or 3000,
    })
  elseif Config.Notification == 'qb' then
    TriggerClientEvent('QBCore:Notify', src, title .. ' ' .. desc, type, duration)
  end
end

function TakeMoney(src, amount, reason)
  if Config.Framework == 'qbx' then
      if qbx:GetMoney(src, 'cash') >= amount then
          qbx:RemoveMoney(src, 'cash', amount, reason)
          return true
      elseif qbx:GetMoney(src, 'bank') >= amount then
          qbx:RemoveMoney(src, 'bank', amount, reason)
          return true
      else
          return false
      end
  elseif Config.Framework == 'qb' then
      local plr = qb.Functions.GetPlayer(src)
      if not plr then return false end
      if plr.Functions.GetMoney('cash') >= amount then
          plr.Functions.RemoveMoney('cash', amount)
          return true
      elseif plr.Functions.GetMoney('bank') >= amount then
          plr.Functions.RemoveMoney('bank', amount)
          return true
      else
          return false
      end
  elseif Config.Framework == 'esx' then
      local xPlayer = ESX.GetPlayerFromId(src)
      if not xPlayer then return false end
      if xPlayer.getMoney() >= amount then
          xPlayer.removeMoney(amount)
          return true
      elseif xPlayer.getAccount('bank').money >= amount then
          xPlayer.removeAccountMoney('bank', amount)
          return true
      else
          return false
      end
  end
end

function AddMoney(src, account, amount, reason)
  if Config.Framework == 'qbx' then
      qbx:AddMoney(src, account, amount, reason)
  elseif Config.Framework == 'qb' then
      local plr = qb.Functions.GetPlayer(src)
      if not plr then return false end
      plr.Functions.AddMoney(account, amount)
  elseif Config.Framework == 'esx' then
      local xPlayer = ESX.GetPlayerFromId(src)
      if not xPlayer then return false end
      if account == 'cash' then
          xPlayer.addMoney(amount)
      elseif account == 'bank' then
          xPlayer.addAccountMoney('bank', amount)
      end
  end
end

function RemoveItem(src, item, amount)
  if Config.Inventory == 'ox' then
      exports.ox_inventory:RemoveItem(src, item, amount or 1)
  elseif Config.Inventory == 'qb' then
      exports['qb-inventory']:RemoveItem(src, item, amount or 1)
  elseif Config.Inventory == 'esx' then
      local xPlayer = ESX.GetPlayerFromId(src)
      if not xPlayer then return end
      xPlayer.removeInventoryItem(item, amount or 1)
  end
end

function AddItem(src, item, amount)
    local src = source
  if Config.Inventory == 'ox' then
      if exports.ox_inventory:CanCarryItem(src, item, amount or 1) then
          exports.ox_inventory:AddItem(src, item, amount or 1)
      else
          Notify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
      end
  elseif Config.Inventory == 'qb' then
      if exports['qb-inventory']:CanAddItem(src, item, amount or 1) then
          exports['qb-inventory']:AddItem(src, item, amount or 1)
      else
          Notify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
      end
  elseif Config.Inventory == 'esx' then
      local xPlayer = ESX.GetPlayerFromId(src)
      if not xPlayer then return end
      if xPlayer.canCarryItem and xPlayer.canCarryItem(item, amount or 1) then
          xPlayer.addInventoryItem(item, amount or 1)
      else
          Notify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
      end
  end
end

function HasItem(src, item, amount)
    amount = amount or 1 

    if Config.Inventory == 'ox' then
        return exports.ox_inventory:GetItem(src, item, nil, true) >= amount

    elseif Config.Inventory == 'qb' then
        local itemData = exports['qb-inventory']:GetItem(src, item)
        return itemData and itemData.amount >= amount

    elseif Config.Inventory == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return false end
        local inventoryItem = xPlayer.getInventoryItem(item)
        return inventoryItem and inventoryItem.count >= amount
    end

    return false
end

function IsPlayerHaveGymPass()
    HasItem(Config.GymPass)
end

function GetPlayerCid(source)
    if Config.Framework == 'qb' then
        local playerCid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        print("QBCore Citizen ID: " .. playerCid)  -- Debugowanie
        return playerCid
    elseif Config.Framework == 'qbox' then
        local playerCid = exports.qbx_core:GetPlayer(source).PlayerData.citizenid
        print("QBox Citizen ID: " .. playerCid)  -- Debugowanie
        return playerCid
    elseif Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerCid = xPlayer.getIdentifier()
        print("ESX Identifier: " .. playerCid)  -- Debugowanie
        return playerCid
    end
end