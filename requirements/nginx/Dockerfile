FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

WORKDIR /tmp

COPY . .

RUN bash ./install-nginx.sh

CMD ["nginx", "-g", "daemon off;"]