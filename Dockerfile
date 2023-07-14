FROM python:3.10.12-slim as python-base

# Packets
RUN apt-get update && apt-get install curl libcairo2 build-essential gcc libmagic1 git ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev neofetch wkhtmltopdf --no-install-recommends -y
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
RUN rm -r nodesource_setup.sh

# speedtest
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
RUN apt-get install speedtest

RUN mkdir /data
RUN git clone https://github.com/hikariatama/Hikka /data/Hikka
WORKDIR /data/Hikka

RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir -U -r optional_requirements.txt

EXPOSE 8000

# Run
CMD python -m hikka --root --port 8000
