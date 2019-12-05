FROM node:12-alpine
WORKDIR /postgraphile/
COPY --from=graphile/postgraphile:4 /postgraphile/ .
ENTRYPOINT [ "./cli.js" ]
