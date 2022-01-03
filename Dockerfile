FROM debian:stable-slim


RUN apt-get update

#install other software
RUN apt-get install tor socat curl -y

# Install cloudflare d
RUN echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/ buster main' | tee /etc/apt/sources.list.d/cloudflare-main.list
RUN curl https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg 
RUN apt-get update
RUN apt-get install cloudflared -y

# copy files

COPY ./etc/ /etc/
COPY ./run.sh /start/

# Cleanup

RUN apt-get clean \\ && rm -rf /var/lib/apt/lists/*

EXPOSE 53/udp
CMD bash -x /start/run.sh