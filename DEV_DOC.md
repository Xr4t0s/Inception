# DEVELOPER DOCUMENTATION

## Setting up

### Prerequisites, config
Prerequisites are installed directly by `./scripts/install.sh`.
Installed components are :
    - Snapd to install other packages
    - Docker and docker-compose-plugin
    - Chromium
    - mkcert to create certificate and verify them locally
    - ntpdate to update date on VM snapshoted and used after too much time

You can manage all the credentials in the `secrets/` folder. It contains 2 files : `.shared.env.example` (shared between containers) and `.wordpress.env.example` (contains wordpress env variables). Copy them without the `.example` suffix and fill them before starting the stack.

### Makefile rules

| Rule | Description |
|------|-------------|
| `all` | Runs `./scripts/install.sh` on the VM |
| `clean` | Stops all containers in `docker-compose.yml` |
| `fclean` | Prunes docker system : clears images, volumes, cache |
| `re` | Runs `fclean` then `all` |
| `check` | Shows the state of running containers |

### Data

Data is stored inside volumes in the user's `$HOME` at `/home/<login>/data/{db,wp}`. These folders are bind-mounted into the containers — useful to inspect or back up DB and WordPress files directly from the host.

## Logs & debug

Stream logs from a specific service :
```
docker compose logs -f nginx
docker compose logs -f wordpress
docker compose logs -f mariadb
```

### Rebuilding a single service

After modifying a Dockerfile or its build context, rebuild only that service without restarting everything :
```
docker compose up -d --build <service>
```

Typical workflow when iterating on a service :
1. Edit the Dockerfile or config files
2. `docker compose up -d --build <service>`
3. `docker compose logs -f <service>` to check the output
