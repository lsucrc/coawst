FROM lsucrc/crcbase 

USER root
#download the delft3d package
RUN mkdir /softwares
WORKDIR /
RUN wget http://simdata.cct.lsu.edu:32777/netcdf-3.6.3.tar.gz
RUN tar -zxvf netcdf-3.6.3.tar.gz
WORKDIR /netcdf-3.6.3
RUN ./configure cc=gcc fc=gfortran --prefix=/softwares/netcdf-3.6.3
RUN make check
RUN make install 

WORKDIR /model
RUN wget http://simdata.cct.lsu.edu:32777/COAWST.tar 
RUN tar -xvf COAWST.tar 
WORKDIR /model/COAWST
RUN make clean
RUN make -j

RUN mkdir /data
RUN ./coawstS < ./ocean_upwelling.in 

ENV PATH $PATH:/model/COAWST

