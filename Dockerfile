FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y curl

RUN apt-get install -y ssh
RUN apt-get install -y rsync

RUN apt-get install -y php libapache2-mod-php php-mcrypt
RUN apt-get install -y php-gd php-ssh2

RUN wget --quiet https://getcomposer.org/installer -O composer-setup.php

RUN php composer-setup.php
RUN rm composer-setup.php
RUN mv composer.phar /usr/bin/composer

RUN apt-get install -y nodejs nodejs-legacy
RUN apt-get install -y npm

RUN npm install -g bower
RUN npm install -g webpack
RUN npm install -g gulp-cli
RUN npm install -g grunt-cli

RUN apt-get install -y ruby
RUN apt-get install -y ruby-dev

RUN gem install compass
RUN gem install compass-normalize
RUN gem install susy
RUN gem install breakpoint


