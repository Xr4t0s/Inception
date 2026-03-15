FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

WORKDIR /tmp

COPY . .

RUN apt-get install -y \
	gnupg2 ca-certificates lsb-release debian-archive-keyring \
	curl procps iproute2

RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
	| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
	https://nginx.org/packages/debian `lsb_release -cs` nginx" \
	| tee /etc/apt/sources.list.d/nginx.list

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/ssl-params.conf /etc/nginx/ssl-params.conf

RUN mkdir -p /etc/nginx/certs
COPY ./certs/*pem /etc/nginx/certs/

RUN apt-get update && apt-get install nginx -y

CMD ["nginx", "-g", "daemon off;"]