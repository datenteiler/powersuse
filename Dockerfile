FROM opensuse
MAINTAINER "Christian Imhorst <christian.imhorst@gmail.com>"
ADD https://packages.microsoft.com/keys/microsoft.asc /tmp/microsoft.asc
ADD https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod/powershell-6.0.1-1.rhel.7.x86_64.rpm /tmp/powershell.rpm
RUN zypper --non-interactive in libunwind libicu libcurl4 screenfetch sudo which vim bind-utils net-tools && \ 
 zypper clean -a && \
 zypper ar https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod dotnet && \
 zypper --no-gpg-check ref && \
 rpm --import /tmp/microsoft.asc && \
 rpm -ivh --nodeps /tmp/powershell.rpm && \
 export uid=1000 gid=1000 && \
 mkdir -p /home/suse && \
 echo "suse:x:${uid}:${gid}:suse,,,:/home/suse:/bin/bash" >> /etc/passwd && \
 echo "suse:x:${uid}:" >> /etc/group && \
 echo "suse ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/suse && \
 chmod 0440 /etc/sudoers.d/suse && \
 chown ${uid}:${gid} -R /home/suse && \
 export PATH=$PATH:$HOME/dotnet
USER suse
ENV HOME /home/suse
ENV TERM xterm
