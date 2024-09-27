# TODO
FROM python:3.12.2

COPY requirements.txt /src/
WORKDIR /src
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg make automake gcc g++ subversion python3-dev
RUN pip install -r requirements.txt
CMD ["sh", "start_prod.sh"]
