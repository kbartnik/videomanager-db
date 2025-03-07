# VideoManager Database

This project sets up a PostgreSQL database for the VideoManager application using Docker and Docker Compose. It includes custom initialization scripts, secure password management, and persistent data storage.

## Project Structure

```
videomanager_db/
├── db/
│   ├── password.txt
│   └── init-db.sh
├── .env
├── .gitignore
├── .dockerignore
├── docker-compose.yaml
├── Dockerfile
└── README.md
```

## Prerequisites

- Docker
- Docker Compose

## Setup

### 1. Clone the Repository

```sh
git clone https://github.com/yourusername/videomanager_db.git
cd videomanager_db
```

### 2. Create the `.env` File

Create a `.env` file in the project root with the following content:

```env
POSTGRES_DB=videomanager
```

### 3. Create the `password.txt` File

Create a `password.txt` file inside the `db` directory with the PostgreSQL password:

```plaintext
# filepath: password.txt
supersecrit
```

### 4. Build and Run the Containers

Use Docker Compose to build and run the containers:

```sh
docker-compose up -d
```

### 5. Verify the Setup

Check the logs to ensure the PostgreSQL service is running correctly:

```sh
docker-compose logs db
```

## Custom Initialization Script

The `init-db.sh` script performs the following tasks:

- Drops the default `postgres` database.
- Drops the default `postgres` user.
- Logs the start and completion of the script.
- Deletes the script after execution to prevent re-running.

## Health Check

The PostgreSQL service includes a health check to monitor its readiness. The health check uses the `pg_isready` command to ensure the service is up and running.

## Persistent Data Storage

The PostgreSQL data is stored in a named volume (`db-data`) to ensure data is not lost when the container is restarted.

## Secure Password Management

The PostgreSQL password is managed using Docker secrets. The password is stored in the `db/password.txt` file and is not hardcoded in the `Dockerfile` or `docker-compose.yaml`.

## Cleanup

To stop and remove the containers, use the following command:

```sh
docker-compose down
```

To remove the named volume, use the following command:

```sh
docker-compose down -v
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Contact

For any questions or support, please contact [Kurt  Bartnik](mailto:kbartnik@gmail.com).
