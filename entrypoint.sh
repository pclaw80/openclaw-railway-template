#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

echo "[entrypoint] Installing latest OpenClaw..."
npm install -g openclaw@latest --ignore-scripts
echo "[entrypoint] Done. Starting server..."
exec gosu openclaw node src/server.js
