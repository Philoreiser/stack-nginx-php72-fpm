FROM centos:7

ADD centos7-nginx.repo /etc/yum.repos.d/centos7-nginx.repo

RUN yum install -y epel-release wget yum-utils
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm 

RUN yum -y install remi-release-7.rpm
RUN yum-config-manager --enable remi-php72

RUN yum -y update

# Installing nginx 
RUN useradd -u 1000 -g 50 -d /var/lib/nginx -s /sbin/nologin nginx
RUN yum -y install nginx

RUN yum -y install php72
RUN yum -y install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache


RUN yum clean all

# pre-build directory for storing sites config.
RUN mkdir -p /etc/nginx/sites-enabled/

# Output Nginx logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log  && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Execut the nginx
CMD ["nginx", "-g", "daemon off;"]