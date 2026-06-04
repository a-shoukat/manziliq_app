async function sendEmail(_userId, _subject, _body) {
  // Integrate SendGrid
  return { sent: true };
}

module.exports = { sendEmail };
