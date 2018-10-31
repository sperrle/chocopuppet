### sperrle/chocopuppet/Dockerfile #############################################
#
# Project        : chocopuppet
#
# Description    : chocopuppet is a Docker Microsoft Windows Container
#                  with Chocolatey & Puppet preinstalled
#
# URL            : https://hub.docker.com/r/sperrle/chocopuppet/
#
# Version        : v0.2 - 2018-10-31
#
################################################################################
#
# Author         : Manuel Sperrle
# URL            : https://sperrle-it.de
#
# Mail           : chocopuppet@sperrle-it.de
#
################################################################################



# ARG for easy change of version on new build
ARG OS="windowsservercore"
ARG VERSION="1803"

# FROM using ARG
FROM microsoft/$OS:$VERSION



# SHELL: PowerShell.exe
SHELL [ "PowerShell.exe", "-NoProfile", "-C", "$ErrorActionPreference='Stop';" ]



# ARG
ARG COPY="/_docker.copy/chocopuppet/"
ARG DOCKER_ONBUILD=""
ARG PUPPET_APPLY=""
ARG PUPPET_EXECUTE=""
ARG PUPPET_AGENT=""

# COPY before build: copy what we need to build inside
COPY copy/_common.ps1 copy/build.ps1 $COPY

# BUILD
RUN iex "$ENV:COPY/build.ps1";

# COPY after build: copy all the rest ( the complete directory "copy" ) inside
COPY copy $COPY



# VOLUME
## Puppet Agent SSL data
VOLUME "C:/ProgramData/PuppetLabs/puppet/etc/ssl"

# ONBUILD
ONBUILD RUN iex "$ENV:COPY/onbuild.ps1";
ONBUILD VOLUME "C:/ProgramData/PuppetLabs/puppet/etc/ssl"

# ENV
ENV COPY=$COPY
ENV \
DOCKER_ENTRYPOINT="" \
PUPPET_APPLY="" \
PUPPET_EXECUTE="" \
PUPPET_AGENT="" \
PUPPET_SERVICE="" \
PUPPET_ENABLE=""

# ENTRYPOINT: PowerShell.exe
ENTRYPOINT [ "PowerShell.exe", "-NoExit", "-NoProfile", "-C", "$ErrorActionPreference='Continue';", "/_docker.copy/chocopuppet/entrypoint.ps1;" ]



# COPY this DOCKERFILE inside
COPY dockerfile $COPY



#EOF