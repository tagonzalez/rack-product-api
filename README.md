# rack-product-api

# Usage

## CSV files
This project uses CSV files instead of a database for simplicity. One can add their own user to the `users.csv` for example if they choose to by just appending a `username,password` row.

## Commands
```
bin/dev build # Builds the docker containers for the app
bin/dev up # Starts the app with the corresponding Docker containers
bin/dev test # Executes the apps tests in the Docker container
```

Once the app starts it'll run in `0.0.0.0:9292`

## Endpoints
The API requires that you first execute a request to the `auth` endpoint in order to get a token.

Once obtained, the token must be sent in the `Authorization` header as a `Bearer` token for subsequent requests.

Worked example with `curl`
1. Execute a request to the `auth` endpoint with a valid username and password
```shell
curl --location '0.0.0.0:9292/v1/auth' \
--header 'Content-Type: application/json' \
--data '{
    "username": "username",
    "password": "password"
}'

=> {"message":"Authenticated successfully","token":"TOKEN"}%
```
2. Obtain the `TOKEN` and use it in subsequent requests
```shell 
# Getting products
curl --location '0.0.0.0:9292/v1/products' \
--header 'Authorization: Bearer TOKEN'

# Creating products
curl --location '0.0.0.0:9292/v1/products' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer TOKEN' \
--data '{
    "name": "New product name"
}'
```
