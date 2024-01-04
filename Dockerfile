# -----------------------------------------------------------------------------
# ACTION IMAGE
#
# A simple image which just copies and runs the action script.
# -----------------------------------------------------------------------------
# Build a lightweight environment
FROM alpine:3.19

# Copy script
COPY entrypoint.sh /entrypoint.sh

# Increase permissions
RUN chmod +x /entrypoint.sh

# Run script on start
ENTRYPOINT ["/entrypoint.sh"]