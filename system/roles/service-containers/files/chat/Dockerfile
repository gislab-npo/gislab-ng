FROM basic
MAINTAINER GIS.lab <gis.lab@lists.osgeo.org>

ENV DEBIAN_FRONTEND=noninteractive

# install deployment files
ADD templates /etc/ansible/deployment/
ADD deployment.yml /etc/ansible/deployment/deployment.yml

# deployment
RUN ansible-playbook \
    --inventory /etc/ansible/hosts \
    --connection=local \
    /etc/ansible/deployment/deployment.yml

# cleanup
RUN apt-get -y purge \
    ansible \
    software-properties-common
RUN apt-get -y autoremove

RUN rm -rf \
    /var/cache/apt/archives/* \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# ports
EXPOSE 6666 6667 6668

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
