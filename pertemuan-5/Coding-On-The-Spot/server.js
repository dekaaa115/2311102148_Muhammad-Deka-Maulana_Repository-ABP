const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const app = express();
const db = new sqlite3.Database('./database.sqlite');

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

db.run(`CREATE TABLE IF NOT EXISTS mahasiswa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama TEXT,
    nim TEXT,
    jurusan TEXT
)`);

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/form', (req, res) => {
    res.render('form', { data: null });
});

app.get('/data', (req, res) => {
    res.render('table');
});

app.get('/api/mahasiswa', (req, res) => {
    db.all("SELECT * FROM mahasiswa", [], (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ data: rows });
    });
});

app.post('/api/mahasiswa', (req, res) => {
    const { nama, nim, jurusan } = req.body;
    db.run(`INSERT INTO mahasiswa (nama, nim, jurusan) VALUES (?, ?, ?)`, [nama, nim, jurusan], function(err) {
        if (err) {
            return res.status(500).send(err.message);
        }
        res.redirect('/data');
    });
});

app.get('/form/:id', (req, res) => {
    const id = req.params.id;
    db.get(`SELECT * FROM mahasiswa WHERE id = ?`, [id], (err, row) => {
        res.render('form', { data: row });
    });
});

app.post('/api/mahasiswa/:id', (req, res) => {
    const id = req.params.id;
    const { nama, nim, jurusan } = req.body;
    db.run(`UPDATE mahasiswa SET nama = ?, nim = ?, jurusan = ? WHERE id = ?`, [nama, nim, jurusan, id], function(err) {
        res.redirect('/data');
    });
});

app.get('/api/mahasiswa/delete/:id', (req, res) => {
    const id = req.params.id;
    db.run(`DELETE FROM mahasiswa WHERE id = ?`, [id], function(err) {
        res.redirect('/data');
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});