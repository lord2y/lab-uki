FROM debian:sid

RUN apt-get update \
   && apt-get install -y -q \
   mkosi \
   cpio  \
   systemd-ukify \
   systemd-boot  \
   kmod \
   systemd-repart \
   mtools \
   && apt-get autoremove -y \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

COPY mkosi.conf /etc/mkosi/mkosi.conf
COPY postinst.chroot /opt/postinst.chroot

ENTRYPOINT ["/usr/bin/mkosi", "-I", "/etc/mkosi/mkosi.conf"]
