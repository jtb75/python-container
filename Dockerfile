FROM python:3.5.1
LABEL project="DevImages"
RUN useradd -ms /bin/bash  pyuser
RUN echo 'pyuser:pyuser' | chpasswd
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py /app
WORKDIR /app
USER pyuser
ENTRYPOINT ["python"]
CMD ["app.py"]
