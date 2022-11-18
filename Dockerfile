FROM nansencenter/geospaas
LABEL maintainer="Artem Moiseev <artem.moiseev@nersc.no>"

RUN pip install scikit-learn rasterio asf-search geopandas \ 
 && conda install pandas \
 && conda install -c conda-forge folium jupyterlab
# Install Sentinel1denoise package
RUN pip install https://github.com/nansencenter/sentinel1denoised/archive/v1.3.1.tar.gz
RUN apt-get install unzip
# Update meadata vocabularies
# RUN python -c 'import pythesint as pti; pti.update_all_vocabularies()'

EXPOSE 8888
