const {Client} = require('pg');

const client = new Client();
client.connect();
client.query('LISTEN global');

client.on('notification', msg => {
  console.log(msg.channel); // foo
  console.log(msg.payload); // bar!
});
