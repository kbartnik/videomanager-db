# TODO List

## Project Setup

- [x] Set up PostgreSQL database using Docker and Docker Compose
- [ ] Integrate Flyway for database migrations
- [x] Create `.env` file for environment variables
- [x] Update `README.md` with setup instructions

## Database Migrations

- [ ] Create initial migration script (`V1__Initial_setup.sql`)
- [ ] Create additional migration scripts as needed
  - [ ] `V2__Add_new_table.sql`
  - [ ] `V3__Update_schema.sql`

## Flyway Configuration

- [ ] Create `flyway.conf` file with database connection details
- [ ] Ensure Flyway runs migrations during container initialization

## Docker Configuration

- [x] Update `Dockerfile` to include Flyway installation and configuration
- [x] Update `docker-compose.yaml` to build and run the PostgreSQL container with Flyway

## Testing and Verification

- [x] Verify that the PostgreSQL service is running correctly
- [ ] Verify that Flyway migrations are applied correctly
- [x] Verify that the database schema is created as expected

## Documentation

- [ ] Update `README.md` with Flyway integration details
- [ ] Add detailed documentation for each migration script

## Future Enhancements

- [ ] Implement automated tests for database migrations
- [ ] Set up continuous integration (CI) for automated builds and tests
- [ ] Add more detailed logging and monitoring for the PostgreSQL service