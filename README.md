# Spring Boot + Prometheus + Grafana: Observability Demo

Proyecto de observabilidad con Spring Boot + Prometheus + Grafana.

## 📦 Requisitos
- Docker y Docker Compose
- Maven y JDK 21 si se necesita ejecutar local sin Docker


## 🏗️ Construir y levantar todo
### Opcion 1 - Ejecucion local de la app sin docker
```bash
./mvnw spring-boot:run
docker compose -f docker-compose.local.yml up
```

### Opcion 2
```bash
docker compose -f docker-compose.full.yml up
```

Servicios ejecutados:
- App: http://localhost:8080/api/hello
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000  (usuario `admin`, contraseña `admin`)

- El endpoint `/api/hello` introduce **latencia** y **errores 5xx aleatorios** (20%) para demostrar las métricas y la alerta.


## 🚨 Alertas configuradas (Prometheus)

## 🔎 ¿Cómo probar las alertas?

1. Generar tráfico continuo:
   ```bash
   while true; do curl -s http://localhost:8080/api/hello >/dev/null; done &
   ```
2. Ver en Prometheus: [http://localhost:9090/alerts](http://localhost:9090/alerts)
Verás activarse:
- **HighErrorRate** → si hay errores 5xx sostenidos.
- **HighLatencyWarning** → si la latencia P95 supera los umbrales definidos (200 ms).
- **HighLatencyCritical** → si la latencia P95 supera los umbrales definidos (300 ms).

3. Ver en Grafana: [http://localhost:3000/dashboards](http://localhost:3000/dashboards)


## 🧹 Detener y limpiar
```bash
docker compose down -v
```
