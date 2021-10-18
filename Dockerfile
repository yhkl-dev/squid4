FROM centos:7 as builder

WORKDIR /usr/local/src

COPY squid-4.17.tar.gz /usr/local/src/squid-4.17.tar.gz

RUN yum -y install bzip2 gcc gcc-c++ make perl openssl-devel httpd-tools \
 && yum clean all \
 && tar xf squid-4.17.tar.gz

WORKDIR /usr/local/src/squid-4.17

RUN ./configure --prefix=/usr/local/squid --sysconfdir=/etc --enable-arp-acl --enable-linux-netfilter --enable-linux-tproxy --enable-async-io=100 --enable-err-language="Simplify_Chinese" --enable-underscore --enable-poll --enable-gnuregex \
 && make -j 8 \
 && make install \
 && mkdir -p /usr/local/squid/pw && /usr/bin/htpasswd -bc /usr/local/squid/pw/passwd squidssl 123456

FROM centos:7

COPY --from=builder /usr/local/squid /usr/local/squid 
COPY myCA.crt /usr/local/squid/myCA.crt
COPY myCA.pem /usr/local/squid/myCA.pem
COPY squid.conf /etc/squid.conf
COPY mime.conf /etc/mime.conf

COPY entrypoint.sh /usr/local/squid/entrypoint.sh

RUN chmod +x /usr/local/squid/entrypoint.sh

ENTRYPOINT ["/usr/local/squid/entrypoint.sh"]