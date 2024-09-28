FROM opensuse/tumbleweed

RUN zypper ar  --no-gpgcheck https://dl.yarnpkg.com/rpm/ Yarn
RUN zypper in -y yarn
WORKDIR /src/

CMD ["bash", "start.sh"]
