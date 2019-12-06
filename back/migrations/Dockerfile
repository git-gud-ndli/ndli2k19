FROM migrate/migrate:v4.7.0
WORKDIR /db
COPY run.sh .
COPY *.sql migrations/
RUN chmod +x run.sh
ENTRYPOINT [ "./run.sh" ]
