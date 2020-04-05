# Use an official Python runtime as a parent image
FROM python:3-slim

# Set the working directory to /app
ENV DEV=/workspace/dev
ENV DEV_DATA=/workspace/data

# Copy the current directory contents into the container at ${DEV}
WORKDIR ${DEV}
COPY . .

ENV TMP=/tmp

ENV ANACONDA_VERSION="https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh"
ENV ANACONDA_PATH=${TMP}/anaconda.sh
ENV ANACONDA_ROOT=${DEV}/anaconda
ENV ANACONDA_BIN=${ANACONDA_ROOT}/bin

ENV GCLOUD_SDK_VERSION="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-237.0.0-linux-x86_64.tar.gz"
ENV GCLOUD_SDK_PATH=gcloud_sdk.tar.gz
ENV GCLOUD_SDK_ROOT=google-cloud-sdk
ENV GCLOUD_SDK_BIN=google-cloud-sdk/bin

ENV LILYPOND_VERSION="http://lilypond.org/download/binaries/linux-64/lilypond-2.20.0-1.linux-64.sh"
ENV LILYPOND_PATH=${TMP}/lilypond.sh
ENV LILYPOND_ROOT=${DEV}/lilypond
ENV LILYPOND_BIN=${LILYPOND_ROOT}/bin

RUN apt-get update --fix-missing \
  && apt-get install -y \
       wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 \
       asymptote texlive-font-utils pdf2svg \
       silversearcher-ag mercurial less vim \
  && wget --quiet ${ANACONDA_VERSION} -O ${ANACONDA_PATH} \
  && /bin/bash ${ANACONDA_PATH} -b -p ${ANACONDA_ROOT} \
  && rm ${ANACONDA_PATH} \
  && echo "export PATH=${ANACONDA_ROOT}/bin:$PATH" >> ~/.bashrc \
  && wget --quiet ${LILYPOND_VERSION} -O ${LILYPOND_PATH} \
  && /bin/bash ${LILYPOND_PATH} --prefix ${LILYPOND_ROOT} \
  && rm ${LILYPOND_PATH} \
  && rm -rf /var/lib/apt/lists/* \
  && echo "export PATH=${LILYPOND_ROOT}/bin:$PATH" >> ~/.bashrc \
  && wget --quiet ${GCLOUD_SDK_VERSION} -O ${GCLOUD_SDK_PATH} \
  && tar xvf ${GCLOUD_SDK_PATH} \
  && rm -rf ${GCLOUD_SDK_PATH} \
  && ${GCLOUD_SDK_ROOT}/install.sh --quiet --usage-reporting False --command-completion True --path-update True \
  && cp hgrc ~/.hgrc \
  && cp inputrc ~/.inputrc \
  && ${GCLOUD_SDK_BIN}/gcloud components update --quiet

# Install any needed packages specified in requirements.txt
RUN ${ANACONDA_BIN}/pip install --trusted-host pypi.python.org -r ${DEV}/requirements.txt

# Make ports available to the world outside this container
EXPOSE 80 8000 8888

# Run a shell when the container launches
CMD ["/bin/bash"]
