FROM eclipse-mosquitto:2

# Copy custom configuration
COPY mosquitto.conf /mosquitto/config/mosquitto.conf

# Ensure proper permissions
RUN chmod 644 /mosquitto/config/mosquitto.conf
