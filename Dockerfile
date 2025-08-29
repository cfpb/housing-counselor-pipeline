FROM python:3.13-alpine

ENV LANG=en_US.UTF-8
ENV PIP_NO_CACHE_DIR=true
ENV PYTHONUNBUFFERED=1
ENV HOME=/usr/home

WORKDIR ${HOME}

COPY . .
COPY --from=surnet/alpine-wkhtmltopdf:3.22.0-024b2b2-small /bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache \
        aws-cli \
        libxrender \
        fontconfig \
        ttf-dejavu

RUN pip install --upgrade pip setuptools && \
    pip install -r ./requirements.txt

RUN mkdir -p .cache/fontconfig

# Don't run as the root user.
ARG USER=base
RUN adduser -g ${USER} --disabled-password ${USER}
RUN chown -R ${USER}:${USER} ${HOME}

USER ${USER}
