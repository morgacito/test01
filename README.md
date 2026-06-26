# Uuilly - Producción 🚀

Este repositorio contiene la versión compilada y protegida lista para producción.

## 🛠️ Despliegue

1. Copie el archivo `.env.example` a `.env` y configure las variables de entorno de producción:
   ```bash
   cp .env.example .env
   ```

2. Ejecute el siguiente comando para levantar el entorno:
   ```bash
   docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
   ```

## 🔍 Puertos expuestos por defecto
- **Frontend**: Servido por Nginx en el puerto `8080` (apunta al contenedor frontend en el 3000)
- **n8n**: `http://localhost:5678`
- **Flowise**: `http://localhost:3001`
