FROM ubuntu:16.04
MAINTAINER GIS.lab <gis.lab@lists.osgeo.org>

ENV DEBIAN_FRONTEND=noninteractive

# update Apt cache
RUN apt-get --yes update

# install Ansible installation requirements
RUN apt-get --yes install \
    software-properties-common

# install Ansible PPA and update package cache
RUN apt-add-repository --yes --update \
    ppa:ansible/ansible


# install Ansible
RUN apt-get --yes install \
    ansible

# install supervisor
RUN apt-get --yes install \
    supervisor


# prepare for Ansible deployment
RUN echo "[local]\nlocalhost" > /etc/ansible/hosts
RUN mkdir -p /etc/ansible/deployment
