FROM lsucrc/crcbase 

USER crcuser
#download the delft3d package
WORKDIR /
RUN wget http://lsu.ngchc.org/project/crc/models/COAWST/netcdf-3.6.3.tar.gz
RUN tar -zxvf netcdf-3.6.3.tar.gz
WORKDIR /netcdf-3.6.3
RUN ./configure cc=gcc fc=gfortran --prefix=/netcdf-3.6.3
RUN make check
RUN make install 

WORKDIR /model
RUN wget http://lsu.ngchc.org/project/crc/models/COAWST/COAWST.tar 
RUN tar -xvf COAWST.tar 
WORKDIR /model/COAWST
RUN make clean
RUN make -j

#RUN mkdir /data
#RUN ./coawstS < ./ocean_upwelling.in 

#ENV PATH $PATH:/model/COAWST

