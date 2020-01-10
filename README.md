# NextJs + Craft Graphql Example

## Setup

1. Fill in .envrc files (rename .envrc.example to .envrc)
   > If you do not know what envrc is more info on it [here](https://direnv.net/)
2. Run docker compose `docker-compose up` To build and run the docker container to run craft and mariadb
3. Import test craft database with docker

```
docker exec -i ${PROJECT_NAME}--craft--db mysql -u $SQL_USERNAME -p$SQL_PASSWORD craft_${PROJECT_NAME} < ./resources/backup.tar
```

4. Install nextjs dependencies

```
cd next
yarn
```

5. Get the craft graphql access token from craft `/admin/graphql/schemas` and put it in the .envrc under the ./next folder

## Testing

1. Enter next dev mode `yarn dev`
2. When next dev mode is active you can live preview the home page
