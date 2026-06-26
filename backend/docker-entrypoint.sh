#!/bin/sh
# docker-entrypoint.sh simplified

# If the first argument is a command we want to run directly without waiting for DB (like ls, sh, bash)
# we can skip the wait. However, for simplicity and robustness:
if [ "$1" = "uvicorn" ] || [ "$1" = "python" ]; then
    # Wait for PostgreSQL to be ready (Pooled Connection)
    echo "Waiting for PostgreSQL at ${DB_HOST:-postgres}:${DB_PORT:-5432}..."
    while ! pg_isready -h ${DB_HOST:-postgres} -p ${DB_PORT:-5432} -U ${DB_USER:-postgres} > /dev/null 2>&1; do
      sleep 1
    done
    echo "PostgreSQL (Pooled) is ready!"

    # Self-healing: Ensure auxiliary databases exist (Critical for Upgrades)
    # We use the direct connection (5432) to 'postgres' DB for creation
    ensure_db_exists() {
        DB_NAME=$1
        if [ -z "$DB_NAME" ]; then return; fi
        
        echo "Ensuring database '$DB_NAME' exists..."
        # Check if DB exists
        EXISTS=$(PGPASSWORD=${DB_PASSWORD:-postgres} psql -h ${DB_HOST:-postgres} -p 5432 -U ${DB_USER:-postgres} -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
        
        if [ "$EXISTS" != "1" ]; then
            echo "Database '$DB_NAME' does not exist. Creating..."
            PGPASSWORD=${DB_PASSWORD:-postgres} psql -h ${DB_HOST:-postgres} -p 5432 -U ${DB_USER:-postgres} -d postgres -c "CREATE DATABASE \"$DB_NAME\""
            if [ $? -eq 0 ]; then
                echo "Database '$DB_NAME' created successfully."
            else
                echo "Failed to create database '$DB_NAME'!"
                # We don't exit here as it might be a permissions issue, 
                # but migrations will likely fail later.
            fi
        else
            echo "Database '$DB_NAME' already exists."
        fi
    }

    ensure_db_exists "${UUILLY_DB_NAME:-uuilly_db}"
    ensure_db_exists "${FLOWISE_DB_NAME:-flowise_db}"

    # Execute Prisma migrations if they exist
    echo "Applying database migrations..."
    prisma migrate deploy --schema /app/prisma/schema.prisma
    if [ $? -ne 0 ]; then
      echo "Prisma migration failed!"
      exit 1
    fi
    echo "Migrations applied successfully!"
fi

# Execute the main command from the Dockerfile
exec "$@"
