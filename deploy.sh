#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$SCRIPT_DIR/exercises/javascript/app"

echo "=== Building UI ==="
cd "$APP_DIR/ui"
npm install
npm run build

echo "=== Copying UI dist to agent/public ==="
rm -rf "$APP_DIR/agent/public"
cp -r "$APP_DIR/ui/dist" "$APP_DIR/agent/public"

echo "=== Deploying mock-server ==="
cd "$APP_DIR/mock-server"
npm install
cf push

echo "=== Deploying agent (+ UI) ==="
cd "$APP_DIR/agent"
npm install
cf push

echo ""
echo "Deployment complete!"
echo "Agent URL: https://po-agent.cfapps.eu10-005.hana.ondemand.com"
echo "Mock URL:  https://po-mock-server.cfapps.eu10-005.hana.ondemand.com"
