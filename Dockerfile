FROM opensuse
MAINTAINER "Christian Imhorst <christian.imhorst@gmail.com>"
RUN zypper --non-interactive in libunwind libicu libcurl4 screenfetch sudo which vim bind-utils net-tools
ADD https://packages.microsoft.com/keys/microsoft.asc /tmp/microsoft.asc
RUN rpm --import /tmp/microsoft.asc
COPY packages/ /tmp/
RUN rpm -ivh --nodeps /tmp/*.rpm
RUN TERM=xterm
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/suse && \
    echo "suse:x:${uid}:${gid}:suse,,,:/home/suse:/bin/bash" >> /etc/passwd && \
    echo "suse:x:${uid}:" >> /etc/group && \
    echo "suse ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/suse && \
    chmod 0440 /etc/sudoers.d/suse && \
    chown ${uid}:${gid} -R /home/suse
USER suse
ENV HOME /home/suse
RUN export PATH=$PATH:$HOME/dotnet
