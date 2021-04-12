# SpeedrunBlogengine.Umbrella

To run the project you need first to have a Postgres container running on port 5432. We embed a docker-compose configuration to ease setting up the environment.

``` sh
# Run this to have a database on 5432
docker-compose up -d
```

To run tests: `mix test` on the root folder. 
