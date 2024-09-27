#include <amxmodx>
#include <fakemeta>
#include <json>
#include <sockets>

#pragma dynamic 32768

new gSocket = 0;
new gFrame = 0;
new gTimelimit = 0;
new gEffectiveTime = 0;

public plugin_init() {
    register_plugin("AG Stream Overlay", "1.0.0", "7mochi");

    register_message(get_user_msgid("Timer"), "fw_msg_timer");
}

public plugin_cfg() {
    new error = 0;
    gSocket = socket_open("127.0.0.1", 3000, SOCKET_UDP, error, SOCK_NON_BLOCKING | SOCK_LIBC_ERRORS);
}

public plugin_end() {
    socket_close(gSocket);
}

public connect_to_socket() {
    new error;
    gSocket = socket_open("127.0.0.1", 3000, SOCKET_UDP, error, SOCK_NON_BLOCKING | SOCK_LIBC_ERRORS);
}

public fw_msg_timer(id, dest, ent) {
    gTimelimit = get_msg_arg_int(1);
    gEffectiveTime = get_msg_arg_int(2);
}

public server_frame() {
    gFrame++;

    if (gFrame > 30) gFrame = 0;
    else return;

    new JSON:allData = json_init_object();
    new JSON:dataPlayers = json_init_array();

    new players[MAX_PLAYERS], numPlayers;
    get_players(players, numPlayers, "ch");

    new player, health, hev, team[32], name[128], weapon[32], weaponid, clip, ammo, frags, deaths;
    for (new i; i < numPlayers; i++) {
        player = players[i];

        health = max(0, get_user_health(player));
        hev = max(0, get_user_armor(player));
        get_user_team(player, team, charsmax(team));
        get_colorless_name(player, name, charsmax(name));
        weaponid = get_user_weapon(player, clip, ammo);
        
        if (weaponid == 0) {
            weapon = "weapon_none";
        } else {
            get_weaponname(weaponid, weapon, charsmax(weapon));
        }
        
        frags = get_user_frags(players[i]);
        deaths = get_user_deaths(players[i]);

        new JSON:dataPlayer;
        dataPlayer = json_init_object();
        json_object_set_string(dataPlayer, "team", team);
        json_object_set_string(dataPlayer, "name", name);
        json_object_set_number(dataPlayer, "health", health);
        json_object_set_number(dataPlayer, "hev", hev);
        json_object_set_string(dataPlayer, "weapon", weapon);
        json_object_set_number(dataPlayer, "clip", clip);
        json_object_set_number(dataPlayer, "ammo", ammo);
        json_object_set_number(dataPlayer, "frags", frags);
        json_object_set_number(dataPlayer, "deaths", deaths);
        json_array_append_value(dataPlayers, dataPlayer);

        json_free(dataPlayer);
    }

    json_object_set_value(allData, "players", dataPlayers);
    json_object_set_number(allData, "timelimit", gTimelimit);
    json_object_set_number(allData, "effectiveTime", gEffectiveTime);

    send_to_socket(allData);

    json_free(allData);
}

stock send_to_socket(JSON:json) {
    static szBuffer[5120];
    json_serial_to_string(json, szBuffer, charsmax(szBuffer));

    socket_send(gSocket, szBuffer, strlen(szBuffer));
}

stock get_colorless_name(id, name[], len) {
	get_user_name(id, name, len);

	new i, j;
	new const hat[3] = "^^";
	while (name[i]) {
		if (name[i] == hat[0] && name[i + 1] >= '0' && name[i + 1] <= '9') {
			i++;
		} else {
			if (j != i) {
                name[j] = name[i];
            }	
			j++;
		}
		i++;
	}
	name[j] = 0;
}