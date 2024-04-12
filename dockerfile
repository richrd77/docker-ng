FROM nginx:latest

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --system --gid $GROUP_ID nonrootgroup && \
    adduser --system --uid $USER_ID --ingroup nonrootgroup nonroot

RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nonroot:nonrootgroup /var/cache/nginx && \
    chmod -R 770 /var/cache/nginx

RUN sed -i 's#/var/run/nginx.pid#/var/cache/nginx/nginx.pid#' /etc/nginx/nginx.conf

COPY ./dist/docker-ng/browser /usr/share/nginx/html
RUN chown -R nonroot:nonrootgroup /usr/share/nginx/html

EXPOSE 80

USER nonroot

CMD ["nginx", "-g", "daemon off;"]