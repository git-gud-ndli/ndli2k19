export const oidcSettings = {
  authority: "https://ndli-2k19.eu.auth0.com",
  clientId: "0Z68RA33XGrC01R4zT9xp6Y4birGuP4e",
  redirectUri: process.env.VUE_APP_AUTH_REDIRECT,
  responseType: "id_token token",
  scope: "openid profile"
};
