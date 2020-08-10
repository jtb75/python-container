FROM python:3.5.1
LABEL project="DevImages"
RUN useradd -ms /bin/bash  pyuser
RUN echo 'pyuser:pyuser' | chpasswd
USER pyuser
