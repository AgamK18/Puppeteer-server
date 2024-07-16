const cron = require('cron');
const https = require('https');
 
const backendUrl = 'https://puppeteer-server-9laq.onrender.com/healthcheck';
 
const job = new cron.CronJob('*/14 * * * *', function () {
  console.log('Restarting server');
  // Perform an HTTPS GET request to hit any backend API
  https.get(backendUrl, (res) => {
    if (res.statusCode === 200) {
      console.log('Server restarted');
    } else {
      console.error(`Failed to restart server with status code: ${res.statusCode}`);
    }
  }).on('error', (err) => {
    console.error('Error during Restart:', err.message);
  });
});
 
// Export the cron job
module.exports = {
  job,
};
