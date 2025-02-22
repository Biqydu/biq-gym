Config = {}

Config.Debug = true


function debug(msg)
    if Config.Debug then print('^3[DEBUG]^7', msg) end
end

Config.Framework = 'qbox'            -- qb , qbox, esx
Config.Notification = 'ox'         -- ox , qb
Config.Inventory = 'ox'            -- ox , qb, esx
Config.ProgressType = 'ox-circle'      -- ox-normal , ox-circle , qb
Config.OxCirclePosition = 'bottom' -- only matters if Config.ProgressType = 'ox-circle'

Config.GymPass = 'gym_pass' -- item name
Config.GymPassPrice = 100

Config.MaxWorks = 5
Config.Cooldown = 10

Config.Seller = {
    model = 'u_m_y_party_01',
    coords = vec4(-1195.24, -1577.26, 3.61, 122.35),
    target = {
        label = 'Buy Gym Pass',
        icon = 'fas fa-dumbbell',
        distance = 2
    }
}

Config.WorkPositions = { -- types: push-ups, lift, crunches
    {
        type = 'push-ups',
        coords = vec3(-1204.91, -1560.37, 3.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Do Push-Ups',
    },
    {
        type = 'lift',
        coords = vec3(-1210.53, -1561.43, 4.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Do lift',
    },
    {
        type = 'crunches',
        coords = vec3(-1199.96, -1563.94, 3.62),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Do crunches',
    },
}

Config.Progressbars = {
    ['push-ups'] = {
        duration = 10000,
        label = 'Doing Push-Ups...',
        anim = {'amb@world_human_push_ups@male@base', 'base', 1}  -- dict, name, flag
    },
    ['lift'] = {
        duration = 10000,
        label = 'Doing lift...',
        anim = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 1},
        prop = {'prop_curl_bar_01', 28422, vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0) }
    },
    ['crunches'] = {
        duration = 10000,
        label = 'Doing crunches...',
        anim = {'amb@world_human_sit_ups@male@idle_a', 'idle_a', 1}
    },
    ['buying'] = {
        duration = 5000,
        label = 'Buying gym pass...',
    }
}