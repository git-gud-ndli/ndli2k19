const {Client} = require('pg');
const webpush = require('web-push');

webpush.setVapidDetails(
  process.env.WEB_PUSH_CONTACT,
  process.env.PUBLIC_VAPID_KEY,
  process.env.PRIVATE_VAPID_KEY,
);

const client = new Client();
console.log('Paul est lent !!!');

client.connect();
client.query('LISTEN notif_new_question');
client.query('LISTEN notif_new_tag');

client.on('notification', msg => {
  switch (msg.channel) {
    case 'notif_new_question':
      client.query(
        'SELECT endpoint FROM internal.devices AS dev INNER JOIN internal.question_sub AS q ON q.user_id = dev.user_id WHERE q.question_id = $1',
        [msg.payload],
        (err, res) => {
          res.rows.forEach(e => {
            console.log(e);
            const payload = JSON.stringify({
              title: 'Nicolas le pire DJ',
              body: "C'est le pire",
            });

            webpush
              .sendNotification(e, payload)
              .then(result => console.log(result))
              .catch(e => console.log(e.stack));
          });
        },
      );
      break;
    case 'notif_new_question':
      client.query(
        'SELECT endpoint FROM internal.devices AS dev INNER JOIN internal.tag_sub AS t ON s.user_id = dev.user_id WHERE t.tag_id = $1',
        [msg.payload],
        (err, res) => {
          res.rows.forEach(e => {
            console.log(e);
            const payload = JSON.stringify({
              title: 'Nicolas le pire DJ',
              body: "C'est le pire",
            });

            webpush
              .sendNotification(e, payload)
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
