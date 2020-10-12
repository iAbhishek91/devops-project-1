import Express from 'express';

const PORT_NUMBER = 8080;
const app = Express();


app.use(Express.static('./public'));

app.get('/welcome', (_, res) => {
  res.status(200);
  res.send('first DevOps project');
});


app.listen(PORT_NUMBER, () => {
  console.log(`server is listening at port ${PORT_NUMBER}`);
});
