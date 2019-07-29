ARG  DYNAMODB_DOCKER_IMAGE_TAG=latest
FROM amazon/dynamodb-local:$DYNAMODB_DOCKER_IMAGE_TAG

USER root
RUN yum -y install python-pip jq

ENV SRC_DIR=/opt/bootstrap

RUN mkdir -p $SRC_DIR
COPY bootstrap $SRC_DIR
RUN chmod +x $SRC_DIR/scripts/init.sh
RUN chmod +x $SRC_DIR/bootstrap.sh

RUN pip install --upgrade pip
RUN pip install awscli-local

# # We run the init script as a health check
# # That way the container won't be healthy until it's completed successfully
# # Once the init completes we wipe it to prevent it continiously running
HEALTHCHECK --start-period=10s --interval=1s --timeout=3s --retries=30\
  CMD $SRC_DIR/bootstrap.sh || exit 1