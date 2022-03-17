require('dotenv').config();
const pinataApiKey = process.env.PINATA_API_KEY;
const pinataSecretApiKey = process.env.PINATA_SECRET_APIKEY;
const axios = require("axios");
const fs = require("fs");
const FormData = require("form-data");
const pinFileToIPFS = async () => {
  const url = `https://api.pinata.cloud/pinning/pinFileToIPFS`;
  let data = new FormData();
  data.append("file", fs.createReadStream("./unnamed.jpeg"));
  const res = await axios.post(url, data, {
    maxContentLength: "Infinity", 
    headers: {
      "Content-Type": `multipart/form-data; boundary=${data._boundary}`,
      pinata_api_key: pinataApiKey, 
      pinata_secret_api_key: pinataSecretApiKey,
    },
  });
  console.log(res.data);
};
pinFileToIPFS();

// {
//     "name":"bori_unnamed1",
//     "hash": "QmbMBQfgrWXe2ChycDyT7zBgNnGwB3U1NqYgiyqNVag3wY", 
// QmWQybXJbTJQtRsUdLTPaPGuuoB4vkToPvvYr8Y5dE23Qa
// QmafYPE2RVwBGUj6P9ixi2xMoYirToRPn885UF5de6zEyF
//     "description": "Tryin1"
//   }