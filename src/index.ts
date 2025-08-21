import express from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.get('/', (req, res) => {
  res.status(200).send({"message":"Hello from Express + TypeScript!"});
});
app.get('/test', (req, res) => {
  res.status(200).send({"message":"This is a test endpoint"});
});
app.get('/health', (req, res) => {
  res.status(200).send('ok');
});
app.listen(PORT, () => {
  console.log(`Server is running on ${PORT}`);
});
