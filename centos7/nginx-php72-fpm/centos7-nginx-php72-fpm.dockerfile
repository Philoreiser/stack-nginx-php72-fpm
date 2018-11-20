FROM centos:7

ADD centos7-nginx.repo /etc/yum.repos.d/centos7-nginx.repo
RUN yum -y update


# Installing nginx 
RUN useradd -u 1000 -g 50 -d /var/lib/nginx -s /sbin/nologin nginx
RUN yum -y install nginx

RUN yum clean all

# pre-build directory for storing sites config.
RUN mkdir -p /etc/nginx/sites-enabled/

# Output Nginx logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log  && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Execut the nginx
CMD ["nginx", "-g", "daemon off;"]