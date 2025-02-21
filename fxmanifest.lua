fx_version 'cerulean'
game 'gta5'

description 'biq-gym'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'server/*.lua',
    'utils/sv_utlis.lua'
}

client_script {
    'client/*.lua',
    'utils/cl_utlis.lua'
}

dependencies {
    'ox_lib',  -- https://github.com/overextended/ox_lib
    'ox_target'  -- https://github.com/overextended/ox_target
}

files {
    'locales/*.json'
}

lua54 'yes'
use_fxv2_oal 'yes'
