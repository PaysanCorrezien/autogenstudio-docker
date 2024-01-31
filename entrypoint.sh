#!/bin/bash
# entrypoint.sh

# Start AutogenStudio, using environment variables for configuration
export PYTHON_VERSION=3.11
autogenstudio ui --host 0.0.0.0 --port $PORT
