FROM persapiens/oraclejdk:8u171
MAINTAINER Marcelo Fernandes <persapiens@gmail.com>

# install headless gui tools, chromium and create chromium folders
RUN apt-get update -qqy && \
  apt-get upgrade -qqy --no-install-recommends && \
  apt-get install -qqy xvfb dbus-x11 fonts-ipafont-gothic xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic && \
  apt-get install -qqy chromium-browser && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/* && \
  mkdir /.config /.cache /.local /.gnome /.pki && \
  chmod 777 /.config /.cache /.local /.gnome /.pki

# install chrome launch script modification
ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser-original && \
  chmod +x /usr/bin/xvfb-chromium && \
  ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome && \
  ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

