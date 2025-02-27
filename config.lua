Config = {}

Config.Debug = true

Config.Locale = 'en' -- en, pl but you can add more in locales folder
Config.Framework = 'qbox'            -- qb , qbox, esx
Config.Notification = 'ox'         -- ox , qb
Config.Inventory = 'ox'            -- ox , qb, esx
Config.ProgressType = 'ox-circle'      -- ox-normal , ox-circle , qb
Config.OxCirclePosition = 0 -- only matters if Config.ProgressType = 'ox-circle'
Config.Webhook = ''
-- ^ webhook for logging

Config.CheaterDetected = function(source) 
    -- give your logic here, e.g. export from banning
    -- DropPlayer(source, 'You have been detected cheating')
end

Config.GymPass = 'gym_pass' -- item name
Config.GymPassPrice = 100

Config.MaxWorks = 5
Config.Cooldown = 10


Config.Seller = {
    model = 'u_m_y_party_01',
    coords = vec4(-1195.24, -1577.26, 3.61, 122.35),
    target = {
        label = 'Buy membership',
        icon = 'fas fa-dumbbell',
        distance = 2 -- do not set above 6
    }
}

Config.Blip = { -- set to false to disable
    coords = vec3(-1205.73, -1572.39, 4.61),
    icon = 311,
    scale = 0.9,
    color = 0,
    shortRange = true
}

Config.WorkPositions = { -- types: push-ups, lift, crunches, treadmill
    {
        type = 'push-ups',
        coords = vec3(-1202.24, -1574.24, 3.65),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Do push-ups',
    },
    {
        type = 'lift',
        coords = vec3(-1210.07, -1559.81, 4.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Lift weights',
    },
    {
        type = 'lift',
        coords = vec3(-1206.45, -1567.94, 4.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Lift weights',
    },
    {
        type = 'lift',
        coords = vec3(-1208.03, -1565.69, 4.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Lift weights',
    },
    {
        type = 'lift',
        coords = vec3(-1209.79, -1563.03, 4.61),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Lift weights',
    },
    {
        type = 'crunches',
        coords = vec3(-1203.16, -1572.94, 3.65),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Do crunches',
    },
    {
        type = 'treadmill',
        coords = vec3(-1193.66, -1572.31, 4.75),
        size = vec3(2, 2, 2),
        distance = 3,
        label = 'Run',
    },
}

Config.Progressbars = {
    ['push-ups'] = {
        duration = 10000,
        label = 'Doing push-ups...',
        anim = {'amb@world_human_push_ups@male@base', 'base', 1}  -- dict, name, flag
    },
    ['lift'] = {
        duration = 10000,
        label = 'Weightlifting...',
        anim = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 1},
        prop = {'prop_curl_bar_01', 28422, vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0) }
    },
    ['crunches'] = {
        duration = 10000,
        label = 'Doing crunches...',
        anim = {'amb@world_human_sit_ups@male@idle_a', 'idle_a', 1}
    },
    ['treadmill'] = {
        duration = 15000,
        label = 'Running...',
        anim = {'move_m@drunk@moderatedrunk', 'run', 1}
    },
    ['buying'] = {
        duration = 5000,
        label = 'Buying a membership...',
    }
}
