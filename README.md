# Uuilly - ProducciÃ³n ðŸš€

Este repositorio contiene la versiÃ³n compilada y protegida lista para producciÃ³n.

## ðŸ› ï¸ Despliegue

1. Copie el archivo `.env.example` a `.env` y configure las variables de entorno de producciÃ³n:
   ```bash
   cp .env.example .env
   ```

2. Ejecute el siguiente comando para levantar el entorno:
   ```bash
   docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
   ```

## ðŸ” Puertos expuestos por defecto
- **Frontend**: Servido por Nginx en el puerto `8080` (apunta al contenedor frontend en el 3000)
- **n8n**: `http://localhost:5678`
- **Flowise**: `http://localhost:3001`
