ARG PYTHON_BASE_IMAGE=quay.io/ansible/python-base:latest
ARG PYTHON_BUILDER_IMAGE=quay.io/ansible/python-builder:latest

FROM $PYTHON_BUILDER_IMAGE as builder
# =============================================================================

ARG ZUUL_SIBLINGS=""
COPY . /tmp/src
RUN assemble

FROM $PYTHON_BASE_IMAGE
# =============================================================================

COPY --from=builder /output/ /output
RUN /output/install-from-bindep \
  && rm -rf /output
