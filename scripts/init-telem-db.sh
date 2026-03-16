#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$TELEMETRY_POSTGRES_USER" --dbname "$TELEMETRY_POSTGRES_DB" <<-EOSQL
    -- Enable TimescaleDB extension
    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
    
    -- Enable UUID extension for UUID primary keys
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    
    -- Log successful initialization
    SELECT 'TimescaleDB and UUID extensions enabled successfully' as status;
EOSQL