# #!/bin/bash
# ## ToDo:
# ## Get a test case to see if this is the first run or a repeat run
# ## If it's a first run you need to do a full index including all transactions
# ## tx index creates an index of every single transaction in the block history if
# ## not specified it will only create an index for transactions that are related to the wallet or have unspent outputs.
# ## This is specific to chainquery.
#
# ## Ensure perms are correct prior to running main binary
# chown -R 1000:1000 /data
# chmod -R 755 /data
# chown -R 1000:1000 /etc/lbrycrdd
# chmod -R 755 /etc/lbrycrdd
# rm -f /var/run/lbrycrdd.pid
#
# ## For now keeping this simple. Potentially eventually add all command args as envvars for the Dockerfile or use safe way to add args via docker-compose.yml
# ## Command to initialize
# # lbrycrdd \
# #   -conf=${CONF_PATH:-/etc/lbrycrdd/lbrycrdd.conf} \
# #   -data=${DATA_DIR:-/data/} \
# #   -port=${PORT:-9246} \
# #   -pid=${PID_FILE:/var/run/lbrycrdd.pid} \
# #   -printtoconsole \
# #   -rpcport=${RPC_PORT:-9245} \
# #   -rpcpassword=${RPC_PASSWORD:-changeme} \
# #   -rpcuser=${RPC_USER:-lbryrpc} \
# #   -rpcallowip=${RPC_ALLOW_IP:-10.5.1.2} \
# #   -reindex \
# #   -txindex
#
# ## Command to run for long term.
# lbrycrdd \
#   -conf=${CONF_PATH:-/etc/lbrycrdd/lbrycrdd.conf} \
#   -data=${DATA_DIR:-/data/} \
#   -port=${PORT:-9246} \
#   -pid=${PID_FILE:/var/run/lbrycrdd.pid} \
#   -printtoconsole \
#   -rpcport=${RPC_PORT:-9245} \
#   -rpcpassword=${RPC_PASSWORD:-changeme} \
#   -rpcuser=${RPC_USER:-lbryrpc} \
#   -rpcallowip=${RPC_ALLOW_IP:-10.5.1.2} \
#   -txindex
#!/bin/bash

## Ensure perms are correct prior to running main binary
chown -R 1000:1000 /data
chmod -R 755 /data
chown -R 1000:1000 /etc/lbrycrdd
chmod -R 755 /etc/lbrycrdd
rm -f /var/run/lbrycrdd.pid
mkdir -p ~/.lbrycrd

## Set config params
echo -e "rpcuser=lbryrpc\nrpcpassword=${RPC_PASSWORD:-changeme}" > ~/.lbrycrd/lbrycrd.conf
echo -e "rpcallowip=${RPC_ALLOW_IP:-10.5.1.2}" >> ~/.lbrycrd/lbrycrd.conf
echo -e "rpcuser=${RPC_USER:-lbryrpc}" >> ~/.lbrycrd/lbrycrd.conf

## For now keeping this simple. Potentially eventually add all command args as envvars for the Dockerfile or use safe way to add args via docker-compose.yml
lbrycrdd \
  -server \
  -txindex \
  -reindex \
  -conf=$HOME/.lbrycrd/lbrycrd.conf \
  -printtoconsole

## We were unsure if these function as intended so they were disabled for the time being.
#  -port=${PORT:-9246} \
#  -data=${DATA_DIR:-/data/} \
#  -pid=${PID_FILE:/var/run/lbrycrdd.pid} \
#  -rpcport=${RPC_PORT:-9245} \
#  -rpcpassword=${RPC_PASSWORD:-changeme} \
#  -rpcuser=${RPC_USER:-lbryrpc} \
#  -rpcallowip=${RPC_ALLOW_IP:-10.5.1.2}
