FROM debian:sid

RUN apt-get update && apt-get install -y mkosi cpio systemd-ukify systemd-boot kmod systemd-repart mtools
COPY mkosi.conf /images/mkosi.conf
COPY postinst.chroot /images/postinst.chroot

ENTRYPOINT ["/usr/bin/mkosi", "-I", "/images/mkosi.conf"]
