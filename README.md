# rack-product-api

# Usage

## CSV files
This project uses CSV files instead of a database for simplicity. One can add their own user to the `users.csv` for example if they choose to by just appending a `username,password` row.

## Using Docker compose
```
docker-compose up
```

Now the app runs on `0.0.0.0:9292`

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
```
2. 