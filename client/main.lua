if Config.Framework == 'qb' then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
    ESX = exports['es_extended']:getSharedObject()
end

lib.locale(Config.Locale or 'en')

local workTimes = {}

local function CanWork()
  local now = GetGameTimer()
  for i = #workTimes, 1, -1 do
      if (now - workTimes[i]) > (Config.Cooldown * 60 * 1000) then
          table.remove(workTimes, i)
      end
  end
  if #workTimes >= Config.MaxWorks then
    Notify('Gym', locale('workout_reached', Config.MaxWorks, Config.Cooldown), 'error')
      return false
  else
      table.insert(workTimes, now)
      return true
  end
end

local function BuyGymPass()
  if HasItem('money', Config.GymPassPrice) then
      if Progress(Config.Progressbars['buying'].duration, Config.Progressbars['buying'].label) then
          TriggerServerEvent('biq-gym:server:buyGymPass') 
          Notify(locale('gym'), locale('bought_gym_pass'), 'success')
      end
  else
      Notify(locale('gym'), locale('no_enough_money'), 'error')
  end
end

local function DoWork(type)
  if CanWork() then 
      local success = false

      if type == 'push-ups' then
          success = Progress(Config.Progressbars['push-ups'].duration, Config.Progressbars['push-ups'].label, Config.Progressbars['push-ups'].anim)
      elseif type == 'lift' then
          success = Progress(Config.Progressbars['lift'].duration, Config.Progressbars['lift'].label, Config.Progressbars['lift'].anim, Config.Progressbars['lift'].prop)
      elseif type == 'crunches' then
          success = Progress(Config.Progressbars['crunches'].duration, Config.Progressbars['crunches'].label, Config.Progressbars['crunches'].anim)
      elseif type == 'treadmill' then
          success = Progress(Config.Progressbars['treadmill'].duration, Config.Progressbars['treadmill'].label, Config.Progressbars['treadmill'].anim)
      end

      if success then
          Notify(locale('gym'), locale('workout_done', locale(type)), 'success')
      else
          table.remove(workTimes) 
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


CreateThread(function()
if Config.Blip then 
  CreateBlip(Config.Blip.coords.xyz, locale('gym'), Config.Blip.icon, Config.Blip.color, Config.Blip.scale, Config.Blip.shortRange)
  end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
  SpawnGymSeller()
  CreateWorkTargets()
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
end)

