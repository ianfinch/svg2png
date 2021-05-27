# syntax=docker/dockerfile:1

FROM python:alpine as builder
RUN apk update
RUN apk upgrade
RUN apk add gcc cairo python3-dev libffi-dev zlib-dev linux-headers musl-dev jpeg-dev
RUN pip3 install cairosvg

FROM python:alpine
RUN addgroup --gid 1000 -S appuser && adduser --uid 1000 -S appuser -G appuser
USER appuser
COPY --from=builder /usr/local/bin/cairosvg /usr/local/bin/cairosvg
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/lib/libbsd* /usr/lib/
COPY --from=builder /usr/lib/libcairo* /usr/lib/
COPY --from=builder /usr/lib/libpixman* /usr/lib/
COPY --from=builder /usr/lib/libfontconfig* /usr/lib/
COPY --from=builder /usr/lib/libfreetype* /usr/lib/
COPY --from=builder /usr/lib/libpng* /usr/lib/
COPY --from=builder /usr/lib/libxcb* /usr/lib/
COPY --from=builder /usr/lib/libX11* /usr/lib/
COPY --from=builder /usr/lib/libXau* /usr/lib/
COPY --from=builder /usr/lib/libXdmcp* /usr/lib/
COPY --from=builder /usr/lib/libXext* /usr/lib/
COPY --from=builder /usr/lib/libXrender* /usr/lib/
COPY --from=builder /usr/lib/libbrotlicommon* /usr/lib/
COPY --from=builder /usr/lib/libbrotlidec* /usr/lib/
COPY --from=builder /usr/lib/libjpeg* /usr/lib/
COPY --from=builder /etc/fonts /etc/fonts
WORKDIR /home/appuser
CMD ["cairosvg"]
