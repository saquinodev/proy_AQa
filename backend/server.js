require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Conectar a la base de datos
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: 3306,  // Especificamos el puerto correcto
    ssl: { rejectUnauthorized: false } // En caso de requerir conexión segura
  });
  
  db.connect(err => {
    if (err) {
      console.error('Error de conexión a MySQL:', err);
      return;
    }
    console.log('Conectado a MySQL en AWS Lightsail');
  });

// Ruta para el login
app.post('/login', (req, res) => {
  const { usuario, contraseña } = req.body;

  db.query('SELECT * FROM usuarios WHERE usuario = ?', [usuario], async (err, results) => {
    if (err) return res.status(500).json({ success: false, message: 'Error en el servidor' });

    if (results.length === 0) {
      return res.status(401).json({ success: false, message: 'Usuario no encontrado' });
    }

    const user = results[0];
    const isMatch = await bcrypt.compare(contraseña, user.contraseña);

    if (!isMatch) {
      return res.status(401).json({ success: false, message: 'Contraseña incorrecta' });
    }

    // Crear token JWT
    const token = jwt.sign({ id: user.id, tipo: user.tipo }, process.env.JWT_SECRET, { expiresIn: '8h' });

    res.json({ success: true, token, user: { id: user.id, usuario: user.usuario, tipo: user.tipo } });
  });
});

// Iniciar el servidor
app.listen(process.env.PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${process.env.PORT}`);
});
