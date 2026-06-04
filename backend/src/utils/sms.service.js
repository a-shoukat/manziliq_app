async function sendSms(_userId, _message) {
  // Integrate Twilio/Jazz SMS API
  return { sent: true };
}

module.exports = { sendSms };
