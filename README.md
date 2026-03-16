*This project has been created as part of the 42 curriculum by nitadros*

## *Description*

**Inception** is a 42 school project that make you understand how to use **Docker** and its many tools. You will have to deploy a minimum of three **containers** :
- nginx with TLSv1.2/TLSv1.3 only
-	mariadb
- wordpress + php-fpm (manual installation)

**Docker** is a platform used to *build*, *run* and *package* applications in **containers, with its dependencies**, so you can run it the same way on **any system**.

If you **migrate** your application from an OS to a different OS and **try to run the old OS installation scripts**, it will crash. If you used **Docker**, your application could be ran **the same way** from an OS to another.

Also, you can deploy **many containers**, it shares your host kernel, but **containers are isolated** and run on their sides. You can run **multiple applications**, and **customize the way they interect between themselves**, and be sure you could run that on **every production system**.

---
## *Instructions*

You have to respect the following rules if you want to deeply learn about **Docker**. The rules are :
-	The project needs to be installed on a **virtual machine**
-	You have to use the **docker-compose plugin**
- Service names must correspond to container names
-	One service per container
- The containers must be built from **penultimate stable version** of *Debian/Alpine*
-	You have to write one **Dockerfile** per service
- You will call you **Makefile** that will call a **docker-compose.yml** that will finally call your **Dockerfiles**

>	It's forbidden to pull ready images from anywhere !

Then you will have to set up :
-	A **shared volume** between nginx and wordpress
- A **private volume** for mariadb
- The two volumes must store their data **on the host**, at `/home/\<login>/data/{wp,db}`
-	A **docker network** that establishes connection between containers

Last rules : (i know...)
-	Your containers **must restarts** in case of crash
-	No hacky patch like **tail -f** : learn about daemon, foreground/background tasks
- On the **wordpress database**, there must be **two users**, one of them being the admin of wordpress
- You have to configure your **domain** to points to your *local address*

## *Resources*

*AI Usage ->* It's better to only use AI when you need to know what package are needed for wordpress, mariadb, or to correct docker syntaxe. If you never used something try one time with ai explanation, then try yourself.
You can also use AI to tell you more about infrastructure and try to discover new ways of building your application, how to organize multiple app instances like front and backend.


- https://docs.docker.com 

> I didn't use gordon but it's a good idea to start with docker

-	https://nginx.org/en/linux_packages.html#Debian

## *Architecture*

There's the architecture we will use to do this job :

```
├── docker-compose.yml # Our docker entrypoint
├── install.sh # automated script to install dependencies (docker, ...)
├── README.md
├── requirements # The services folders 
│   ├── mariadb
│   │   ├── Dockerfile
│   │   └── tools 
│   │       └── install-mariadb.sh # post-build script
│   ├── nginx
│   │   ├── conf # nginx pre-built configuration
│   │   │   ├── nginx.conf
│   │   │   └── ssl-params.conf
│   │   └── Dockerfile
│   └── wordpress
│       ├── Dockerfile
│       └── tools
│           └── install-wordpress.sh # post-build script
├── secrets # env variables
└── USER_DOC.md # User documentation
```

