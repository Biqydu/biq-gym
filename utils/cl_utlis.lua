if Config.Framework == 'qb' then 
  QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then 
  ESX = exports['es_extended']:getSharedObject()
end

---@param duration number # length of progress
---@param label string # progress text
---@param anim table # {dict, clip}
---@param  prop table #  {model, bone, pos, rot}
function Progress(duration, label, anim, prop)
    if Config.ProgressType == 'qb' then
        local propData = {}

        if prop then
            propData = {
                model = prop[1],
                bone = prop[2] or 60309,
                pos = prop[3] or vec3(0.1, 0, 0),
                rot = prop[4] or vec3(0, 0, 0)
            }
        end

        QBCore.Functions.Progressbar(label, label, duration, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = anim and anim[1] or nil,
            anim = anim and anim[2] or nil,
        }, {}, propData, function()
            return true
        end, function()
            return false
        end)
    
    elseif Config.ProgressType == 'ox-normal' then
        local options = {
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                combat = true,
                car = true
            }
        }

        if anim then
            options.anim = {
                dict = anim[1],
                clip = anim[2],
                flag = anim[3] or 49
            }
        end

        if prop then
            options.prop = {
                model = prop[1],
                bone = prop[2] or 60309, 
                pos = prop[3] or vec3(0.1, 0, 0),
                rot = prop[4] or vec3(0, 0, 0)
            }
        end

        if lib.progressBar(options) then
            return true
        else
            return false
        end

    else
        local options = {
            duration = duration,
            label = label,
            position = Config.OxCirclePosition,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true
            }
        }

        if anim then
            options.anim = {
                dict = anim[1],
                clip = anim[2],
                flag = anim[3] or 49
            }
        end

        if prop then
            options.prop = {
                model = prop[1],
                bone = prop[2] or 60309, 
                pos = prop[3] or vec3(0.1, 0, 0),
                rot = prop[4] or vec3(0, 0, 0)
            }
        end

        if lib.progressCircle(options) then
            return true
        else
            return false
        end
    end
end


---@param title string # noti title can be empty string for qb
---@param desc string # noti desc
---@param type string # success or error
---@param duration number # Length of noti
function Notify(title, desc, type, duration)
  if Config.Notification == 'qb' then
      QBCore.Functions.Notify(title .. ": " .. desc, type, duration)
  else
      lib.notify({
          title = title,
          description = desc,
          type = type or 'info',
          duration = duration or 3000,
      })
  end
end


function HasItem(item, amount)
    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:GetItemCount(item)
        return count > 0
    elseif Config.Inventory == 'qb' then
        local count = exports['qb-inventory']:HasItem(item, amount or 1)
        return count > 0
    elseif Config.Inventory == 'esx' then
        local count = ESX.SearchInventory(item, amount or 1)
        return count > 0
    end
end


function SpawnPed(model, coords)
    lib.requestModel(model)
    local ped = CreatePed(1, joaat(model), coords.xyz, coords.w, true, false)
    SetModelAsNoLongerNeeded(joaat(model))
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)

    return ped
end

function IsPlayerHaveGymPass()
    return HasItem(Config.GymPass)
end