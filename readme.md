# AutogenStudio Docker

A dockerfile to quickly deploy AutogenStudio.

## Setting up AutogenStudio with Docker Compose

1. Clone the AutogenStudio Docker repository:

   ```bash
   git clone https://github.com/paysancorrezien/autogenstudio-docker.git
   ```

2. Navigate to the `autogenstudio-docker` directory:

   ```bash
   cd autogenstudio-docker
   ```

3. Edit the `.env` file in the same directory with your configuration. For example:

   ```
   OPENAI_API_KEY=your_actual_key
   PYTHON_VERSION=3.11
   ```

   Replace `your_actual_key` with your actual OpenAI API key.

4. Modify the `docker-compose.yml` if you need specific settings. It should work out of the box.

   This docker-compose work for me just fine:

   ```yaml
   version: "4"
   services:
     autogenstudio:
       image: autogenstudio
       environment:
         - PYTHON_VERSION=${PYTHON_VERSION}
         - OPENAI_API_KEY=${OPENAI_API_KEY}
       ports:
         - "8001:8001"
       env_file:
         - .env
       volumes:
         - db_volume:/usr/local/lib/python${PYTHON_VERSION}/site-packages/autogenstudio/web/
         - source_volume:/usr/local/lib/python${PYTHON_VERSION}/site-packages/
   volumes:
     db_volume:
       name: autogenstudio_db
     source_volume:
       name: autogenstudio_sources
   ```

   If you just want to get it running quickly, you can also use :

```bash
 docker run -p 8001:8001 -e OPENAI_API_KEY=your_actual_key -d autogenstudio
```

5. Build the Docker image:

   ```bash
   docker build -t autogestudio .
   ```

6. Run AutogenStudio using Docker Compose:

```bash
docker compose up -d
```

The `-d` flag runs the container in detached mode, so it continues to run in the background.

7. To access the AutogenStudio web interface, open a web browser and go to:

   ```
   http://localhost:8001
   ```

   You should be able to access AutogenStudio through the web interface.

8. Verify that AutogenStudio is running by checking the logs:

   ```bash
   docker-compose logs -f autogenstudio
   ```

9. Troubleshooting

To launch shell on container :

```bash
 docker run -it --entrypoint /bin/bash autogenstudio -s
```

### Note : Database Backup

All the settings are stored in a local database.[GitHub Post](https://github.com/microsoft/autogen/issues/1442)
The AutogenStudio database is stored in a local Docker volume named `autogenstudio_db`. Its where the customs agents/ skills/ workflows are stored.
If you want to export or backup them use the docker volumes

By default, Docker volumes are stored on your local machine. You can find the data in a directory similar to:

```
/var/lib/docker/volumes/autogenstudio_db/_data
```

There you should see a `database.sqlite` file.
