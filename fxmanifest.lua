fx_version 'cerulean'

game 'gta5'

author 'Salty'
description 'A heromission script for FiveM'

lua54 'yes'

server_scripts {
	'server.lua',
	'custom.lua'
}

client_script 'client.lua'

shared_scripts {
	'config.lua',
	'callback.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
	'ui/libraries/axios.min.js',
	'ui/libraries/vue.min.js',
	'ui/libraries/vuetify.css',
	'ui/libraries/vuetify.js',
	'ui/script.js',
	'ui/style.css',
}