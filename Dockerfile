FROM ubuntu:bionic

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y zip unzip wget curl \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ssh git subversion \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y rsync s3cmd \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential libssl-dev \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y php php-gd php-ssh2 php-curl php-mbstring \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ruby ruby-dev \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python python3 \
    && rm -rf /var/lib/apt/lists/* \
	&& rm /bin/sh && ln -s /bin/bash /bin/sh

# Setup PHP Composer
RUN wget --quiet https://getcomposer.org/installer -O composer-setup.php \
	&& php composer-setup.php \
	&& rm composer-setup.php \
	&& mv composer.phar /usr/bin/composer

# Setup Compass
RUN gem install compass compass-normalize susy breakpoint

# Setup Node
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
	&& apt-get install -y nodejs

RUN npm install -g yarn bower webpack-cli gulp-cli grunt-cli 

# Setup AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
	&& unzip awscliv2.zip \
	&& ./aws/install