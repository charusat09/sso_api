# Rails SSO Backend with Docker and Doorkeeper

This repository contains a Rails application configured as an SSO backend, using Docker for containerization and Doorkeeper for OAuth2 authentication. The application integrates with Devise for user management and supports token-based authentication with refresh tokens.

## Table of Contents

- [Setup](#setup)
- [Configuration](#configuration)
- [Running the Application](#running-the-application)
- [Testing OAuth2 Authentication](#testing-oauth2-authentication)
- [Generating Tokens](#generating-tokens)
- [Refreshing Tokens](#refreshing-tokens)
- [API Endpoints](#api-endpoints)
- [License](#license)

## Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo

2. **Ensure Docker and Docker Compose are installed on your machine.**

3. **Build and run the Docker containers:**

   ```bash
   docker-compose up --build

4. **Setup the database:**
   ```bash
   docker-compose run backend rails db:create db:migrate db:seed

## Configuration

### Environment Variables
Ensure you have the following environment variables set in your Docker environment:
   ```
   GOOGLE_CLIENT_ID: Your Google OAuth2 Client ID
   GOOGLE_CLIENT_SECRET: Your Google OAuth2 Client Secret
```

### Devise and Doorkeepe
The application uses Devise for user authentication and Doorkeeper for OAuth2. The Doorkeeper configuration is located in `config/initializers/doorkeeper.rb`.

**Registering Your App in Doorkeeper**
To register your application with Doorkeeper using Rails console:
```bash
   docker-compose run backend rails console
   app = Doorkeeper::Application.create!(
           name: 'Your App Name',
           redirect_uri: 'https://your-app-redirect-url.com',
           scopes: 'your_scopes'
         )

    puts "Client ID: #{app.uid}"
    puts "Client Secret: #{app.secret}"
```
Replace 'Your App Name', 'https://your-app-redirect-url.com', and 'your_scopes' with your application's name, redirect URI, and desired scopes respectively.

## Running the Application
Start the application using Docker Compose:

```bash
docker-compose up
```

The Rails server will be available at http://localhost:3001.

## Testing OAuth2 Authentication
## Generating Tokens
To obtain an access token and refresh token using the password grant type, use the following curl command:

```bash
curl -X POST \
  -d "grant_type=password&username=user1@example.com&password=password&client_id=<your_client_id>&client_secret=<your_client_secret>" \
  http://localhost:3001/oauth/token
```

Example response:

```json
{
  "access_token": "access_token",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "refresh_token"
}
```

## Refreshing Tokens
To refresh an access token using a refresh token, use the following curl command:

```bash
curl -X POST \
  -d "grant_type=refresh_token&refresh_token=<refresh_token>&client_id=<your_client_id>&client_secret=<your_client_secret>" \
  http://localhost:3001/oauth/token
```

Example response:
```json
{
  "access_token": "new_access_token",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "new_refresh_token"
}
```

## API Endpoints
### Protected Endpoint
The application includes a protected endpoint that requires authentication:

```http
GET /api/v1/tests
```

Example curl command to access the protected endpoint:

```bash
curl -X GET \
  http://localhost:3001/api/v1/tests \
  -H "Authorization: Bearer <access_token>"
```
