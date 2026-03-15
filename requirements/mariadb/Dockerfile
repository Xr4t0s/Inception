FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

WORKDIR /tmp

COPY . .

RUN bash ./install-mariadb.sh

CMD ["mariadbd", "--user=mysql", "--bind-address=0.0.0.0"]