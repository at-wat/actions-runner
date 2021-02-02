#!/bin/bash

sudo sed -i "s|http://archive.ubuntu.com/ubuntu/|${DEB_REPOSITORY_BASE_URL}|" /etc/apt/sources.list
exec $@
