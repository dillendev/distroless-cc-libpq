FROM debian:buster-slim AS builder

RUN apt-get update && \
    apt-get install -y libpq5 && \
    rm -rf /var/lib/apt/lists/*

FROM gcr.io/distroless/cc-debian11 AS release

# Setup dependencies for libpq
ARG ARCH
ARG TARGETARCH

COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libssl.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libcrypto.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libgssapi_krb5.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libldap_r-2.4.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libkrb5.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libk5crypto.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libkrb5support* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/liblber-2.4.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libsasl2.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libgnutls.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libp11-kit.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libidn2.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libunistring.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libtasn1.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libnettle.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libhogweed.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libgmp.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libffi.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libcom_err.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libkeyutils.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libcom_err.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=builder /usr/lib/${ARCH}-linux-gnu/libpq.so* /usr/lib/${ARCH}-linux-gnu/

LABEL org.opencontainers.image.description="Distroless CC + libpq image for ${TARGETARCH}"
