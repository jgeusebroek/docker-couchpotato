#!/bin/sh
set -x

USERNAME=${USERNAME:=couchpotato}
GROUP=${GROUP:=couchpotato}

# Add user if it does not exist
if ! id -u "${USERNAME}" >/dev/null 2>&1; then
	addgroup -g ${USER_GID:=4000} ${GROUP}
	adduser -G ${GROUP} -D -u ${USER_UID:=4000} ${USERNAME}
fi

touch /config/potato.cfg
mkdir -p /config/data
chmod ${USERNAME}:${GROUP} /config

chown -R ${USERNAME}:${GROUP} /config
sudo -u ${USERNAME} -E sh -c "/opt/couchpotato/CouchPotato.py --config_file /config/potato.cfg --data_dir /config/data --console_log $@"