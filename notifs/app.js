const {Client} = require('pg');
const webpush = require('web-push');

webpush.setVapidDetails(
  process.env.WEB_PUSH_CONTACT,
  process.env.PUBLIC_VAPID_KEY,
  process.env.PRIVATE_VAPID_KEY,
);

const client = new Client();

client.connect();
client.query('LISTEN notif_new_question');

client.on('notification', msg => {
  switch (msg.channel) {
    case 'notif_new_question':
      client.query(
        'SELECT endpoint, p256dh, auth FROM internal.devices AS dev INNER JOIN internal.question_sub AS q ON q.user_id = dev.user_id WHERE q.question_id = $1',
        [msg.payload],
        (err, res) => {
          res.rows.forEach(({ endpoint, p256dh, auth }) => {
            console.log(e);
            const payload = JSON.stringify({
              title: 'Nicolas le pire DJ',
              body: "C'est le pire",
            });

            webpush
              .sendNotification({
                endpoint,
                keys: {
                  p256dh,
                  auth
                }
              }, payload)
              .then(result => console.log(result))
              .catch(e => console.log(e.stack));
          });
        },
      );
      break;
  }
  console.log(msg.channel); // foo
  console.log(msg.payload); // bar!
});
