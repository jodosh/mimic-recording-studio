# TODO
FROM python:3.13.0rc2-slim

COPY requirements.txt /src/
WORKDIR /src
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg make automake gcc g++ subversion python3-dev
RUN pip install -r requirements.txt
CMD ["sh", "start_prod.sh"]
