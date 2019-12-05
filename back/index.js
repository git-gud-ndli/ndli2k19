const http = require("http");
const { postgraphile } = require("postgraphile");

const s = postgraphile(
  process.env.DATABASE_URL,
  "api",
  {
    retryOnInitFail: true,
    dynamicJson: true,
    watchPg: true,
    graphiql: true,
    enhanceGraphiql: true,
    ignoreRBAC: true,
  }
);

http
  .createServer(s)
  .listen(process.env.PORT || 3000);
