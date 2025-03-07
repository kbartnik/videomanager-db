# syntax=docker/dockerfile:1

# Use the official PostgreSQL image as the base image
FROM postgres:latest

# Update existing apt-get packages
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Create a non-privileged user named 'dev'
RUN useradd -m -s /bin/bash dev

# Set the environment variables for PostgreSQL
# Use ARG to pass the password securely during build time
ARG POSTGRES_PASSWORD
ENV POSTGRES_USER=dev
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=videomanager

# Copy the custom initialization script
COPY init-db.sh /docker-entrypoint-initdb.d/

# Change permissions on the custom initialization script
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Expose the default PostgreSQL port
EXPOSE 5432

# Set the default command to run PostgreSQL
CMD ["postgres"]
