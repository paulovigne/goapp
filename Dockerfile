# builder image
FROM golang:1.16-alpine3.14 as builder-goapp
RUN mkdir /build
ADD ./goapp/ /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -o goapp .

# build migration tool
FROM golang:1.16-alpine3.14 as builder-migrate
RUN mkdir /build
ADD ./migrate/ /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -o migrate .

# generate clean, final image for end users
FROM alpine:3.14

### Node Vars
ENV APPUSER appuser

### APP Vars
ENV APP_BASEDIR /app
ENV APP_PORT 8080

ARG POSTGRES_URL 

# Creating node user, install basic packages

RUN if [ `getent passwd | grep ${APPUSER} | wc -l` -eq 0 ] \
    ; then \
             addgroup -g 1000 ${APPUSER} \
             && adduser -u 1000 -G ${APPUSER} -s /bin/sh -D ${APPUSER} \
    ; fi \
    && apk -U upgrade

# Install App
RUN mkdir ${APP_BASEDIR}
WORKDIR ${APP_BASEDIR}
COPY --from=builder-goapp /build/goapp .
COPY --from=builder-migrate /build/migrate .

# Change Owner
RUN chown -R ${APPUSER}. ${APP_BASEDIR}

# Set User
USER ${APPUSER}

# ports
EXPOSE ${APP_PORT}

# executable
CMD [ "./goapp" ]
