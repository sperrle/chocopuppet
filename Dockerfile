### sperrle/chocopuppet/Dockerfile #############################################
#
# Project        : chocopuppet
#
# Description    : chocopuppet is a Docker Microsoft Windows Container
#                  with Chocolatey & Puppet preinstalled
#
# URL            : https://hub.docker.com/r/sperrle/chocopuppet/
#
# Version        : v0.1 - 2018-10-29
#
################################################################################
#
# Author         : Manuel Sperrle
# URL            : https://sperrle-it.de
#
# Mail           : chocopuppet@sperrle-it.de
#
################################################################################



# SET ARG for easy change of version on new build
ARG VERSION="1803"

# FROM using ARG
FROM microsoft/windowsservercore:$VERSION



# SHELL: PowerShell.exe
SHELL [ "PowerShell.exe", "-NoProfile", "-C", "$ErrorActionPreference='Stop';" ]



# SET ARG for BUILD
ARG COPY="/_docker.copy/chocopuppet/"

# COPY what we need to build inside
COPY copy/build.ps1 copy/_common.ps1 $COPY

# BUILD
RUN iex "$ENV:COPY/build.ps1";



# SET ENV
ENV COPY=$COPY
ENV \
DOCKER_ENTRYPOINT="" \
PUPPET_APPLY="" \
PUPPET_EXECUTE="" \
PUPPET_AGENT="" \
PUPPET_SERVICE="" \
PUPPET_ENABLE=""


# COPY all the rest ( the complete directory "copy" ) inside
COPY copy $COPY

# ENTRYPOINT: PowerShell.exe
ENTRYPOINT [ "PowerShell.exe", "-NoExit", "-NoProfile", "-C", "$ErrorActionPreference='Continue';", "/_docker.copy/chocopuppet/entrypoint.ps1;" ]



# VOLUME for Puppet Agent SSL data
VOLUME "C:/ProgramData/PuppetLabs/puppet/etc/ssl"
ONBUILD VOLUME "C:/ProgramData/PuppetLabs/puppet/etc/ssl"



# COPY this DOCKERFILE inside
COPY dockerfile $COPY



#EOF