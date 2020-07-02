/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */

/* ----------------- Load.env Variables ----------------- */
const dotenv = require('dotenv');
dotenv.config({ path: `${__dirname}/config/config.env` });

/* -------- Console Log Color in Development Mode ------- */
if (process.env.NODE_ENV === 'development') require('colors');

/* ---------------------- Database ---------------------- */
const connectDB = require('./database/connectDB');

/* ------------------------------------------------------ */
/*            UNCAUGHT EXCEPTION ERROR HANDLER            */
/* ------------------------------------------------------ */
process.on('uncaughtException', (err) => {
    console.log(err.name, err.message);
    process.env.NODE_ENV === 'development'
        ? console.log(
              '💥💥💥',
              'UNCAUGHT EXCEPTION! Shutting down...'.red.inverse
          )
        : console.log('💥💥💥', 'UNCAUGHT EXCEPTION! Shutting down...');
    process.exit(1);
});

/* ------------------------------------------------------ */
/*                       LAUNCH API                       */
/* ------------------------------------------------------ */

/* ----------------- Database Connection ---------------- */
connectDB();

/* ------------------ API Instantiation ----------------- */

const app = require('./app');

const port = process.env.PORT;
const server = app.listen(port, () => {
    process.env.NODE_ENV === 'development'
        ? console.log(
              '🚀🚀🚀',
              `Pokemon API running on port ${port}`.black.bgCyan
          )
        : console.log('🚀🚀🚀', `Pokemon API running on port ${port}`);
});

/* ------------------------------------------------------ */
/*            UNHANDLED REJECTION ERROR HANDLER           */
/* ------------------------------------------------------ */
process.on('unhandledRejection', (err) => {
    console.log(err.name, err.message);
    process.env.NODE_ENV === 'development'
        ? console.log(
              '💥💥💥',
              'UNHANDLED REJECTION! Shutting down...'.red.inverse
          )
        : console.log('💥💥💥', 'UNHANDLED REJECTION! Shutting down...');
    server.close(() => process.exit(1));
});
