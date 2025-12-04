const express = require("express");
const app = express();

app.get("/health", (req, res) => {
  res.json({ status: "ok", service: "billing-service" });
});

const PORT = process.env.PORT || 3002;

app.listen(PORT, () => {
  console.log(`Billing Service running on port ${PORT}`);
});
