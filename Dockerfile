FROM sameersbn/ubuntu:14.04.20160504

ENV SKYPE_USER=skype

# Set the locale
ENV LANG zh_TW.UTF-8
ENV LANGUAGE zh_TW:zh
ENV LC_ALL zh_TW.UTF-8
ENV XMODIFIERS=@im=gcin
ENV GTK_IM_MODULE=gcin
ENV QT_IM_MODULE=gcin

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7212620B \
 && echo "deb http://archive.canonical.com/ trusty partner" >> /etc/apt/sources.list \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && /usr/share/locales/install-language-pack zh_TW \
 && locale-gen zh_TW.UTF-8 \
 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive locales \
 && DEBIAN_FRONTEND=noninteractive apt-get -qqy --no-install-recommends install xfonts-wqy fonts-wqy-zenhei fonts-wqy-microhei language-pack-zh-hant \
                                                 fonts-ipafont-gothic xfonts-100dpi xfonts-75dpi xfonts-cyrillic \
                                                 xfonts-scalable \
 && ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-tw.conf \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y pulseaudio:i386 skype:i386 xfonts-wqy fonts-wqy-zenhei fonts-wqy-microhei language-pack-zh-hant \
 && rm -rf /var/lib/apt/lists/*

COPY scripts/ /var/cache/skype/
COPY entrypoint.sh /sbin/entrypoint.sh
EXPOSE 9999
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
