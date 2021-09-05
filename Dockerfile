# set base image (host OS)
FROM python:3.9.7-buster

# Install ffmpeg
RUN apt-get update && apt-get install -y \
  ffmpeg \
  && rm -rf /var/lib/apt/lists/*

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory
COPY app/requirements.txt .

# install dependencies
RUN pip install -r requirements.txt

# copy main application last. This is to utilize cache in-case parameters inside dl.py are to change.
COPY app/dl.py .

# command to run on container start
CMD [ "python", "./dl.py" ]
