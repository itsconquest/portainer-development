FROM ubuntu

# Expose port for the Portainer UI
EXPOSE 9000

WORKDIR /src

# Set TERM as noninteractive to suppress debconf errors
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install packages
RUN apt-get update --fix-missing && apt-get install -qq \
    dialog \
    apt-utils \
    curl \
    build-essential \
    nodejs \
    git \
    wget \
    supervisor

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get -y install yarn

# Install Golang
RUN cd /tmp \
    && wget -q https://dl.google.com/go/go1.13.11.linux-amd64.tar.gz \
    && tar -xf go1.13.11.linux-amd64.tar.gz \
    && mv go /usr/local

# Configure Go
ENV PATH "$PATH:/usr/local/go/bin"

# Confirm installation
RUN go version && node -v && yarn -v

# Clone the Portainer GitHub
RUN cd /src \
    && git clone https://github.com/portainer/portainer.git

# Install dependencies
RUN cd portainer \
    && yarn \
    && cd api \
    && go build cmd/portainer/main.go \
    && rm main

# Import supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Default command when running the container
CMD supervisord