# USER DOCUMENTATION

## Services

The services provided by this stack are :
    - A reverse proxy : nginx with TLSv1.3
    - A database : mariadb
    - A website : wordpress

## First launch

Before running anything, copy and fill the example env files in the `secrets/` folder :

```
cp secrets/.shared.env.example secrets/.shared.env
cp secrets/.wordpress.env.example secrets/.wordpress.env
```

Edit both files with your credentials. Without this step, `make all` will fail or produce an unconfigured stack.

## Start and stop

To start the stack, run : `make all` — it will run `bash ./scripts/install.sh` in the background, where configuration and installation are made.

To stop : `make clean`  
To stop and remove all data : `make fclean`

## Access and management

When the stack is running, access the wordpress site at https://\<your_login\>.42.fr.

> **SSL warning** : the certificate is generated locally with mkcert. Your browser will eventually show a security warning on first access - this is expected. Accept the exception to proceed.

> If you're running the stack on a VM or outside the 42 network, make sure `<your_login>.42.fr` resolves correctly (check `/etc/hosts` if needed).

> You can manage credentials and users directly from the WordPress dashboard if you're not familiar with DB manipulation.

## Checks and troubleshooting

Run `make check` to see the state of running containers.

If the site doesn't load :
1. Check that all containers are up with `make check`
2. Look at the logs : `docker compose logs -f <service>` (services : `nginx`, `wordpress`, `mariadb`)
3. Make sure your env files are correctly filled
