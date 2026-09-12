return (table.freeze({
    IDENTIFIER_CAP = 65536,
    IDENTIFIER_CAP_STRING = "2^16",
    SERVER_CONNECT_LOG = "bridge '%*' was fired by [%*] with data: \n===============\n%* (%*B)\n===============\n",
    SERVER_FIRE_LOG = "fired bridge '%*' to players: %* with data: \n===============\n%* (%*B)\n===============\n",
    CLIENT_CONNECT_LOG = "bridge '%*' was fired with data: \n===============\n%* (%*B)\n===============\n",
    CLIENT_FIRE_LOG = "fired bridge '%*' with data: \n===============\n%* (%*B)\n===============\n",
}))