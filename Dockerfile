# syntax=docker/dockerfile:1

# Use the official PostgreSQL image as the base
FROM postgres:latest

# Set the environment variables for PostgreSQL
# Set PostgreSQL user from environment (development only)
ENV POSTGRES_USER=${POSTGRES_USER}
# Set the database name from environment (development only)
ENV POSTGRES_DB=${POSTGRES_DB}
# Path for secrets if using in production
ENV POSTGRES_PASSWORD_FILE=/run/secrets/postgres-password

# Create the directories for the custom scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy the custom initialization scripts (will mount the local directory in docker-compose)
# If there are additional scripts needed at build time, they can be copied here.
# For example:
# COPY db/init-db.sh /docker-entrypoint-initdb.d/

# Change permissions on the custom initialization scripts
RUN chmod 755 /docker-entrypoint-initdb.d/init-db.sh

# Expose the default PostgreSQL port
EXPOSE 5432  

# CMD is acknowledged by the base image as the default command to run PostgreSQL
CMD ["postgres"]  # This will start PostgreSQL server