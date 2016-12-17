FROM ubuntu

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y wget
RUN apt-get install -y curl

RUN apt-get install -y git
RUN apt-get install -y ssh
RUN apt-get install -y rsync
RUN apt-get install -y s3cmd

RUN apt-get install -y build-essential libssl-dev
RUN apt-get install -y php libapache2-mod-php php-mcrypt
RUN apt-get install -y php-gd php-ssh2

RUN wget --quiet https://getcomposer.org/installer -O composer-setup.php

RUN php composer-setup.php
RUN rm composer-setup.php
RUN mv composer.phar /usr/bin/composer

RUN apt-get install -y ruby
RUN apt-get install -y ruby-dev

RUN gem install compass
RUN gem install compass-normalize
RUN gem install susy
RUN gem install breakpoint

# RUN apt-get install -y nodejs nodejs-legacy
# RUN apt-get install -y npm

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

RUN source $NVM_DIR/nvm.sh && nvm ls
RUN echo $PATH

RUN npm install -g bower
RUN npm install -g webpack
RUN npm install -g gulp-cli
RUN npm install -g grunt-cli
RUN npm install -g slack-cli