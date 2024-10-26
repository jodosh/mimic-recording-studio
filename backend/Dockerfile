# TODO
FROM opensuse/tumbleweed

RUN zypper ar --no-gpgcheck http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
RUN zypper refresh
RUN zypper install -y ffmpeg make automake gcc gcc-c++ subversion python312-devel
FROM python:3.13-slim

COPY requirements.txt /src/
WORKDIR /src
RUN pip install -r requirements.txt
CMD ["sh", "start_prod.sh"]
