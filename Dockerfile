FROM archlinux/base:latest
LABEL authors="M0Rf30"

# Base installation
RUN pacman -Syyu --noconfirm --noprogressbar && \
    pacman -S --noconfirm --needed --noprogressbar \
    base-devel \
    git \
    go \
    ttf-roboto
    
# Add user, group sudo
RUN /usr/sbin/groupadd --system sudo && \
    /usr/sbin/useradd -m --groups sudo user && \
    /usr/sbin/sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    /usr/sbin/echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install yay - https://github.com/Jguer/yay
RUN su - user -c "cd /home/user && git clone https://aur.archlinux.org/yay.git"
RUN su - user -c "cd /home/user/yay && makepkg -s"
RUN cd /home/user/yay && pacman -U yay-*.tar.xz --noconfirm
RUN rm -rf /home/user/yay

# Set correct locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Perform a clean
RUN rm -rf /var/cache/pacman/pkg/*
RUN rm -rf /home/user/.cache

RUN locale-gen en_US.UTF-8
ENV LC_CTYPE 'en_US.UTF-8'

USER user
