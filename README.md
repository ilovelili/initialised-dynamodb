# Initialised Dynamodb

An image which adds automatic initialisation to local dynamodb

## Bootstrapping

Scripts are copied to `/opt/bootstrap/scripts`.
By default the init.sh script creates a Dynamodb table using [`awscli-local`](https://github.com/localstack/awscli-local)

## Healthcheck

The image runs the bootstrapping scripts as a health check. This means that the service isn't considered `healthy` until they complete. This can therefore be used to control startup order within docker compose (see example below). **Do not override the health check!**

### Runtime overrides

For overriding init script at runtime:

- To directly use `awslocal` on the Cli, mount a Volume over `/opt/bootstrap/scripts` containing an `init.sh` script.
[awslocal](https://github.com/localstack/awscli-local) is installed and used for bootstrapping scripts.

## docker-compose

Here's an example compose file.

```yaml
version: "2.3"

services:
  dynamodb:
    image: ilovelili/initialised-dynamodb:latest
    volumes:
      - ./scripts/myinit.sh:/opt/bootstrap/scripts/init.sh
    ports:
      - "8000:8000"

  some-service:
    image: myorg/some-service
    depends_on:
      dynamodb:
        condition: service_healthy
```

## Web UI

`http://localhost:8000/shell` by default
