# Spring Boot + Prometheus + Grafana: Observability Demo

Proyecto mínimo para evaluación técnica con **métricas (TPS, P95)**, **errores 5xx** y **alerta crítica** (>10% de 5xx por 2 minutos).

## 📦 Requisitos
- Docker y Docker Compose
- (Opcional) Maven y JDK 17 si quieres ejecutar local sin Docker

## 🏗️ Construir y levantar todo
```bash
docker compose up --build
```
Servicios:
- App: http://localhost:8080/api/hello
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000  (usuario `admin`, contraseña `admin`)

> Grafana ya viene **provisionado** con el datasource Prometheus y el dashboard
**Spring Boot Observability Dashboard**.


## 🚨 Alertas configuradas (Prometheus)

## 🔎 ¿Cómo probar las alertas?

1. Ejecutar la aplicación (local o en contenedor).
2. Generar tráfico continuo:
   ```bash
   while true; do curl -s http://localhost:8080/api/hello >/dev/null; done
   ```
3. Ver en Prometheus: [http://localhost:9090/alerts](http://localhost:9090/alerts)

Verás activarse:
- **HighErrorRate** → si hay errores 5xx sostenidos.
- **HighLatencyWarning / Critical** → si la latencia P95 supera los umbrales definidos.

Cómo verificar:
1. Abre Prometheus → **Alerts** → verás **HighErrorRate** en *Pending* / *Firing* cuando supere el umbral.
2. En Grafana puedes añadir alertas adicionales si deseas (opcional).


## 🧹 Detener y limpiar
```bash
docker compose down -v
```

## 📝 Notas para la evaluación
- El endpoint `/api/hello` introduce **latencia** y **errores 5xx aleatorios** (20%) para demostrar las métricas y la alerta.
- El dashboard muestra **TPS**, **Error %**, y **P95** con umbrales (verde/ámbar/rojo).
- Puedes justificar SLOs: p.ej., *P95 < 800ms*, *Error 5xx < 5%*.
