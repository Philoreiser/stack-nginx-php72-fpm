FROM centos:7

ADD centos7-nginx.repo /etc/yum.repos.d/centos7-nginx.repo

RUN yum install -y epel-release wget yum-utils which vim
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm 

RUN yum -y install remi-release-7.rpm
RUN yum-config-manager --enable remi-php72

RUN yum -y update

# Installing nginx 
RUN useradd -u 1000 -g 50 -d /var/lib/nginx -s /sbin/nologin nginx
RUN yum -y install nginx

RUN yum install -y php72 php72-php-cli php72-php-pecl-apcu php72-php-mysqlnd php72-php-mbstring php72-php-opcache php72-php-fpm nginx
RUN yum install -y php72-php-pecl-json-post php72-php-pecl-jsonc php72-php-pecl-jsond
RUN yum install -y php72-php-pecl-igbinary php72-php-pecl-redis
RUN yum install -y php72-php-soap
RUN yum clean all


RUN ln -sf /usr/bin/php72 /usr/local/bin/php




# pre-build directory for storing sites config.
RUN mkdir -p /etc/nginx/sites-enabled/

# Output Nginx logs
# RUN ln -sf /dev/stderr /opt/remi/php72/root/var/log/php-fpm/error.log && \
RUN ln -sf /dev/stdout /var/log/nginx/access.log  && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Execut the nginx
CMD ["nginx", "-g", "daemon off;"]