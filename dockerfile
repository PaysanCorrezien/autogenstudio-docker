# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update \
  && apt-get install -y wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install AutogenStudio
RUN pip install --no-cache-dir autogenstudio

# Set the OPENAI_API_KEY environment variable
# Note: Replace 'your-key-here' with your actual OpenAI API key in your .env file or Docker run command
ENV OPENAI_API_KEY=

# Define the default port for AutogenStudio
ARG PORT=8001
ENV PORT $PORT
EXPOSE $PORT

COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh
RUN ls -la /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]




