FROM ubuntu:jammy

RUN apt update -y && \
    apt install -y openssh-server net-tools nano sudo

RUN adduser --disabled-password --gecos "" ansible && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir /var/run/sshd && \
    mkdir /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh

COPY ./authorized_keys /home/ansible/.ssh/authorized_keys
RUN chmod 600 /home/ansible/.ssh/authorized_keys && \
    chown -R ansible:ansible /home/ansible/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
