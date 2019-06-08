: '
from https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198:

docker run --rm   --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data  postgres

We have provided several options to the docker run command:

— rm: Automatically remove the container and it’s associated file system upon
exit. In general, if we are running lots of short term containers, it is good
practice to to pass rm flag to the docker run command for automatic cleanup and
avoid disk space issues. We can always use the v option (described below) to
persist data beyond the lifecycle of a container

— name: An identifying name for the container. We can choose any name we want.
Note that two existing (even if they are stopped) containers cannot have the
same name. In order to re-use a name, you would either need pass the rm flag to
the docker run command or explicitly remove the container by using the command
docker rm [container name].

-e: Expose environment variable of name POSTGRES_PASSWORD with value docker to
the container. This environment variable sets the superuser password for
PostgreSQL. We can set POSTGRES_PASSWORD to anything we like. I just choose it
to be docker for demonstration. There are additional environment variables you
can set. These include POSTGRES_USER and POSTGRES_DB. POSTGRES_USER sets the
superuser name. If not provided, the superuser name defaults to postgres.
POSTGRES_DB sets the name of the default database to setup. If not provided, it
defaults to the value of POSTGRES_USER.

-d: Launches the container in detached mode or in other words, in the
background.

-p: Bind port 5432 on localhost to port 5432 within the container. This option
enables applications running out side of the container to be able to connect to
the Postgres server running inside the container.

-v: Mount $HOME/docker/volumes/postgres on the host machine to the container
side volume path /var/lib/postgresql/data created inside the container. This
ensures that postgres data persists even after the container is removed.
'

docker run --rm   --name pg-docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:$HOME/Desktop/postgres/backups  postgres
sudo chown -R postgres:postgres $HOME/docker/volumes/postgres
