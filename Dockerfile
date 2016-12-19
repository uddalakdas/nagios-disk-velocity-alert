FROM jasonrivers/nagios:latest

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:ImageNow!' | chpasswd;
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "export LC_ALL=en_US.UTF-8" >> /etc/environment

RUN echo "service ssh start" | cat - /etc/environment > /tmp/out && mv /tmp/out /etc/environment
EXPOSE 22


COPY objects/ /opt/nagios/etc/objects/
COPY sendEmail/ /opt/nagios/libexec/sendEmail/
COPY nagios.cfg /opt/nagios/etc/
COPY velocity.sh /opt/nagios/libexec/
COPY space.sh /opt/nagios/libexec/
COPY startup.sh /

RUN chmod +x /startup.sh


CMD ["/startup.sh"]