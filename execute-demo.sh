#!/bin/bash
set -e

type=${1:-"local"}

echo "📥 Obteniendo secretos desde AWS SSM..."

mkdir -p secrets

# Leer secretos desde SSM y guardarlos temporalmente
MSYS2_ARG_CONV_EXCL="*" aws ssm get-parameter --name "/grafana/admin/username" \
  --with-decryption --query "Parameter.Value" --output text \
  > secrets/grafana_admin_user.txt

MSYS2_ARG_CONV_EXCL="*" aws ssm get-parameter --name "/grafana/admin/password" \
  --with-decryption --query "Parameter.Value" --output text \
  > secrets/grafana_admin_password.txt

echo "✅ Secretos leidos desde SSM..."

# Levantar stack localmente
if [ "$type" == "local" ]; then
  echo "🧪 La aplicacion debe ejecutarse con Maven: ./mvnw spring-boot:run"
  echo "🚀 Levantando Prometheus y Grafana con Docker..."
  docker compose -f docker-compose.local.yml up -d
else
  echo "🚀 Levantando stack full docker..."
  docker compose -f docker-compose.full.yml up -d
fi

# Borrar secretos locales después del deploy
rm -rf secrets

echo "🚀 Stack levantado correctamente. "
echo "Prometheus listo en http://localhost:9090"
echo "Grafana listo en http://localhost:3000"
