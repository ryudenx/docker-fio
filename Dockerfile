FROM rockylinux/rockylinux:latest

LABEL maintainer="Ryuden <master+unixbench@ryuden.org>"

# install
RUN yum update -y \
    && yum install -y \
    fio

WORKDIR /

ENTRYPOINT ls / \
    # IOPS
    && fio --directory=/ --direct=1 --rw=rw --bs=4k --size=100M --numjobs=16 --iodepth=64 --runtime=1m --group_reporting --name=fiotest1 \
    && rm -f /fiotest1* \
    && fio --directory=/ --direct=1 --rw=randrw --bs=4k --size=100M --numjobs=16 --iodepth=64 --runtime=1m --group_reporting --name=fiotest2 \
    && rm -f /fiotest2* \

    # スピード
    && fio --directory=/ --direct=1 --rw=rw --bs=32k --size=100M --numjobs=16 --iodepth=64 --runtime=1m --group_reporting --name=fiotest1 \
    && rm -f /fiotest1* \
    && fio --directory=/ --direct=1 --rw=randrw --bs=32k --size=100M --numjobs=16 --iodepth=64 --runtime=1m --group_reporting --name=fiotest2 \
    && rm -f /fiotest2*

# 公式ドキュメント
# https://fio.readthedocs.io/en/latest/fio_doc.html