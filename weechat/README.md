In lieu of just putting my passwords and stuff online, I'll use these instructions to set up weechat on new machines:

server_default
--------------

    'stuff'

irc.desertbus.org
-----------------

    /server add desertbus irc.desertbus.org/6697
    /set irc.server.desertbus.autoconnect on
    /set irc.server.desertbus.autojoin "#desertbus,#unmoderated,#help,#games,#@"
    /set irc.server.desertbus.sasl_password "I'm sure you'd like to know"
    /set irc.server.desertbus.sasl_username "Not telling you this either"
    /set irc.server.desertbus.ssl on
    /set irc.server.desertbus.ssl_verify off
