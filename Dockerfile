FROM opensuse
LABEL maintainer "Christian Imhorst <christian.imhorst@gmail.com>"
ADD https://packages.microsoft.com/keys/microsoft.asc /tmp/microsoft.asc
ADD https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod/powershell-6.0.1-1.rhel.7.x86_64.rpm /tmp/powershell.rpm
RUN zypper --non-interactive up && \
    zypper --non-interactive in libunwind libicu screenfetch sudo vim bind-utils net-tools kmod && \ 
    zypper clean -a && \
    zypper ar https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod dotnet && \
    zypper --no-gpg-check ref && \
    rpm --import /tmp/microsoft.asc && \
    rpm -ivh --nodeps /tmp/powershell.rpm && \
    rm -rf /tmp/powershell.rpm && \
    export uid=1000 gid=1000 && \
    mkdir -p /home/suse && \
    echo "suse:x:${uid}:${gid}:suse,,,:/home/suse:/bin/bash" >> /etc/passwd && \
    echo "suse:x:${uid}:" >> /etc/group && \
    echo "suse ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/suse && \
    chmod 0440 /etc/sudoers.d/suse && \
    chown ${uid}:${gid} -R /home/suse && \
    export PATH=$PATH:$HOME/dotnet
USER suse
ADD --chown=suse:suse https://raw.githubusercontent.com/datenteiler/powersuse/master/Get-User.psm1 /home/suse/Get-User.psm1
ADD --chown=suse:suse https://raw.githubusercontent.com/datenteiler/powersuse/master/Show-Modules.psm1 /home/suse/Show-Modules.psm1
ADD --chown=suse:suse https://raw.githubusercontent.com/datenteiler/powersuse/master/Get-FreeDiskSpace.psm1 /home/suse/Get-FreeDiskSpace.psm1
ENV HOME /home/suse
ENV TERM xterm
