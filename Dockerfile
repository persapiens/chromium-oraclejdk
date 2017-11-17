FROM persapiens/oraclejdk:8u152
MAINTAINER Marcelo Fernandes <persapiens@gmail.com>

# update and upgrade
RUN apt-get update -qqy && \
    apt-get upgrade -qqy --no-install-recommends

# install headless gui tools
RUN apt-get install -qqy xvfb dbus-x11 fonts-ipafont-gothic xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

# install chromium
RUN apt-get install -qqy chromium-browser

# install chrome launch script modification
RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser-original
ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN chmod +x /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# fix chrome error
# ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# clean temporary files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# create chromium folders
RUN mkdir /.config /.cache /.local /.gnome /.pki && \
    chmod 777 /.config /.cache /.local /.gnome /.pki
