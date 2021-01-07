FROM quay.io/ansible/python-builder:latest as builder
# =============================================================================

ARG ZUUL_SIBLINGS=""
COPY . /tmp/src
RUN assemble

FROM quay.io/ansible/python-base:latest
# =============================================================================

COPY --from=builder /output/ /output
RUN /output/install-from-bindep \
  && rm -rf /output
