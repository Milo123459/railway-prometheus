FROM prom/prometheus

RUN curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o envsubst \
    chmod +x envsubst
    sudo mv envsubst /usr/local/bin

# copy the Prometheus configuration file
RUN envsubst < prometheus.yml > /etc/promtheus/prometheus.yml
# expose the Prometheus server port
EXPOSE 9090

# set the entrypoint command
USER root
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--storage.tsdb.retention=365d", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles", \
             "--web.external-url=http://localhost:9090", \
             "--log.level=info"]
 
