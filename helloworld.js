var arDrone = require('ar-drone');
var client = arDrone.createClient();

client.animateLeds('blinkGreenRed', 5, 10);
client.on('navdata', console.log);
