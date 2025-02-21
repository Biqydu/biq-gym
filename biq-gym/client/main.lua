if Config.Framework == 'qb' then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
    ESX = exports['es_extended']:getSharedObject()
end

local function BuyGymPass()
  if HasItem('money', Config.GymPassPrice) then
      if Progress(5000, 'Buying gym pass') then
          if TriggerServerEvent('biq-gym:server:buyGymPass') then 
          Notify('', 'You bought a gym pass', 'success')
          end
      end
  else
      Notify('', 'You do not have enough money to buy a gym pass', 'error')
  end
end

local function DoWork(type)
  if type == 'push-ups' then
      if Progress(Config.Progressbars['push-ups'].duration, Config.Progressbars['push-ups'].label, Config.Progressbars['push-ups'].anim) then
          Notify('Gym', 'You have done push-ups', 'success')
      end
    elseif type == 'pull-ups' then
      if Progress(Config.Progressbars['pull-ups'].duration, Config.Progressbars['pull-ups'].label, Config.Progressbars['pull-ups'].anim) then
          Notify('Gym', 'You have done pull-ups', 'success')
      end
    elseif type == 'crunches' then
      if Progress(Config.Progressbars['crunches'].duration, Config.Progressbars['crunches'].label, Config.Progressbars['crunches'].anim) then
          Notify('Gym', 'You have done crunches', 'success')
      end
  end
end

local function CreateWorkTargets()
  for _, v in pairs(Config.WorkPositions) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        options = {
            {
                distance = v.distance,
                name = 'biq-gym:Work_' .. v.type,
                icon = 'fas fa-dumbbell',
                label = v.label,
                onSelect = function()
                  DoWork(v.type)
                end,
                canInteract = function()
                  return IsPlayerHaveGymPass()
                end
            }
        }
    })
  end
end

local function SpawnGymSeller()
  local seller = SpawnPed(Config.Seller.model, Config.Seller.coords)

  exports.ox_target:addLocalEntity(seller, {
      {
          distance = Config.Seller.target.distance,
          name = 'biq-gym:buyGymPass',
          icon = Config.Seller.target.icon,
          label = Config.Seller.target.label,
          onSelect = function()
              BuyGymPass()
          end,
      }
  })
end

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
  SpawnGymSeller()
  CreateWorkTargets()
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
end)