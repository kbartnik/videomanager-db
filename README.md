# VideoManager Database

This project sets up a PostgreSQL database for the VideoManager application using Docker and Docker Compose. It includes custom initialization scripts, secure password management, and persistent data storage.

## Project Structure

```
videomanager_db/
├── db/
│   ├── password.txt
│   ├── readonly-password.txt
│   ├── dev-password.txt
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
POSTGRES_DB=video_manager
POSTGRES_USER=dev_user
```

### 3. Create the Password Files

Create `readonly-password.txt` and `dev-password.txt` files inside the `db` directory with the PostgreSQL passwords. These files will be used as Docker secrets:

```plaintext
# filepath: readonly-password.txt
your_readonly_password_here
```

```plaintext
# filepath: dev-password.txt
your_dev_password_here
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
- Creates the `video_manager` and `video_manager_dev` databases.
- Creates the `readonly_user` and `dev_user` roles with appropriate permissions.
- Logs the start and completion of the script.
- Deletes the script after execution to prevent re-running.

## Health Check

The PostgreSQL service includes a health check to monitor its readiness. The health check uses the `pg_isready` command to ensure the service is up and running.

## Persistent Data Storage

The PostgreSQL data is stored in a named volume (`db-data`) to ensure data is not lost when the container is restarted.

## Secure Password Management

The PostgreSQL passwords are managed using Docker secrets. The passwords are stored in the `db/readonly-password.txt` and `db/dev-password.txt` files and are not hardcoded in the `Dockerfile` or `docker-compose.yaml`.

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
