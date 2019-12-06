const jwt = require('express-jwt');
const jwksRsa = require('jwks-rsa');
const express = require("express");
const { postgraphile } = require("postgraphile");

const app = express();

app.use('/graphql', jwt({
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `${process.env.OIDC_ISSUER}.well-known/jwks.json`
  }),
  credentialsRequired: false,
  issuer: process.env.OIDC_ISSUER
}));

app.use('/graphql', (req, res, next) => {
  console.log(req.user);
  next();
});

app.use(postgraphile(
  process.env.DATABASE_URL,
  "api",
  {
    retryOnInitFail: true,
    dynamicJson: true,
    watchPg: true,
    graphiql: true,
    enhanceGraphiql: true,
    ignoreRBAC: true,
    enableCors: true,
    pgSettings: req => (req.user ? {
      'jwt.claims': JSON.stringify(req.user)
    } : {})
  }
));

app.listen(process.env.PORT || 3000);
