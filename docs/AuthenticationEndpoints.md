# Authentication Endpoints

## Register User
POST /api/auth/register

Creates a new RaceDay user account.

## Login
POST /api/auth/login

Authenticates an existing user.

Possible responses include:

- 200 OK
- 201 Created
- 400 Bad Request
- 401 Unauthorized