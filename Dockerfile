# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Install SSH server and MySQL server
RUN apt-get update && \
    apt-get install -y openssh-server mysql-server && \
    mkdir /var/run/sshd

# Set root password for SSH
RUN echo 'root:aaic123' | chpasswd

# Allow root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Set environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=yourmysqlpassword

# Expose SSH and MySQL ports
EXPOSE 22 3306

# Start SSH and MySQL services
CMD service mysql start && /usr/sbin/sshd -D
