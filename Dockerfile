FROM ubuntu:16.04

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y zip unzip wget curl \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ssh git \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y rsync s3cmd \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential libssl-dev \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y php php-gd php-ssh2 php-mcrypt \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ruby ruby-dev \
    && rm -rf /var/lib/apt/lists/* 

RUN wget --quiet https://getcomposer.org/installer -O composer-setup.php

RUN php composer-setup.php \
	&& rm composer-setup.php \
	&& mv composer.phar /usr/bin/composer


RUN gem install compass \
	&& gem install compass-normalize \
	&& gem install susy \
	&& gem install breakpoint

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 7.2.0

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
	&& source $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN source $NVM_DIR/nvm.sh && nvm ls && echo $PATH

RUN npm install -g bower webpack gulp-cli grunt-cli slack-cli