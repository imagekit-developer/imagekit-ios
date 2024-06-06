const dotenv = require('dotenv');
const express = require('express');
const jwt = require('jsonwebtoken');
const app = express();
const cors = require('cors');

dotenv.config();

app.use(cors());
app.use(express.json());

const publicKey = process.env.PUBLIC_KEY;
const privateKey = process.env.PRIVATE_KEY;

app.post("/auth", function (req, res) {
  const token = jwt.sign(
    req.body.uploadPayload,
    privateKey,
    {
      expiresIn: req.body.expire,
      header: {
        alg: "HS256",
        typ: "JWT",
        kid: publicKey,
      },
    })
  res.status(200);
  res.send({ token });
});

app.listen(8080, function () {
  console.log("Live at Port 8080");
});