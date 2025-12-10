const express = require('express');
const app = express();

app.get('/health', (req, res) => {
    res.json({
        status: "ok",
        service: "appointment-service"
    });
});

app.get('/appointments', (req, res) => {
    res.json([
        { id: 1, patient: "John Doe", time: "10:00 AM" },
        { id: 2, patient: "Alice Smith", time: "11:30 AM" }
    ]);
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, "0.0.0.0", () => {
    console.log(`appointment-service running on port ${PORT}`);
});
