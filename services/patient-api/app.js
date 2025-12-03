const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.get("/health", (req, res) => {
  res.json({ status: "ok", service: "patient-api" });
});

app.listen(port, () => {
  console.log(`patient-api listening on port ${port}`);
});
