FROM postgres:latest

# Install curl and cron
RUN apt-get update && apt-get install -y curl cron && rm -rf /var/lib/apt/lists/*

# Copy schema files
COPY schema /schema

# Set up init script permissions
RUN chmod +x /schema/UKRDC/scripts/sync_codes.sh

# Set up cron job to run sync_codes.sh weekly on Sundays at 2am UTC (2 hours after registry codes build)
RUN echo "0 2 * * 0 /schema/UKRDC/scripts/sync_codes.sh >> /var/log/sync_codes.log 2>&1" | crontab -

# Create entrypoint script to start cron alongside postgres
RUN echo '#!/bin/bash\n\
cron\n\
exec docker-entrypoint.sh postgres' > /usr/local/bin/custom-entrypoint.sh && \
    chmod +x /usr/local/bin/custom-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
