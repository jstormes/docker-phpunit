FROM digitalroominc/prism-base-php56

RUN apt-get update \ 
 && apt-get install -y git zlib1g-dev \
 && pecl install xdebug \
 && docker-php-ext-enable xdebug \
 && echo "zend_extention=$(find /usr/local/lib/php/extentions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_port=9998" >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_host=10.254.254.254" >> /usr/local/etc/php/conf.d/xdebug.ini \

 && docker-php-ext-install zip \
 && curl -sS https://getcomposer.org/installer \ | php -- --install-dir=/usr/local/bin --filename=composer \
 && composer global require phpunit/phpunit phpunit/dbunit phing/phing sebastian/phpcpd phploc/phploc phpmd/phpmd squizlabs/php_codesniffer

ENV PATH="/root/.composer/vendor/bin:${PATH}"