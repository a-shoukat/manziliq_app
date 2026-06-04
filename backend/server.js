require('dotenv').config();
const createApp = require('./src/app');
const { PORT } = require('./src/config/env');

const app = createApp();

app.listen(PORT, () => {
  console.log(`ManzilIQ backend running on port ${PORT} (Supabase)`);
});
