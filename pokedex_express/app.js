/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
// const path = require('path');
const express = require('express');
// const cookieParser = require('cookie-parser');

/* ----------------- Safety Middlewares ----------------- */
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');

/* ----------- Cross - Origin Request Sharing ----------- */
const cors = require('cors');

/* --------------------- API Routes --------------------- */
const pokemonRouter = require('./routes/pokemon.router');

/* ------------------------------------------------------ */
/*                   APP INITIALIZATION                   */
/* ------------------------------------------------------ */
const app = express();

/* ------------------------------------------------------ */
/*                       TRUST PROXY                      */
/* ------------------------------------------------------ */
// Use case specific
// Check: https://expressjs.com/fr/guide/behind-proxies.html
// app.enable("trust proxy")

/* ------------------------------------------------------ */
/*                   UTILITY MIDDLEWARES                  */
/* ------------------------------------------------------ */
/* ----------------- Safety Middlewares ----------------- */
// Secure Express app by setting various HTTP headers
app.use(helmet());

// Limit repeated requests to public APIs
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 request per windowMs
    message: 'Too many requests from this IP, please try again in an hour'
});
app.use('/api', limiter);

// Sanitize inputs against query selector injection attacks
app.use(mongoSanitize());

// Sanitize inputs against cross-site scripting
app.use(xss());

// Protect against param pollution (e.g. query duplication)
app.use(hpp()); // allowed field duplication can be whitelisted

/* ----------- Cross - Origin Request Sharing ----------- */
// Allow CORS requests for client-server model deployed app
app.use(cors());

/* ----------------------- General ---------------------- */
// Parse cookie header and populate req.cookies
// app.use(cookieParser());

// Parse incoming requests with JSON payloads and populate req.body
app.use(express.json({ limit: '100kb' })); // default limit value

// Log HTTP request in development mode
if (process.env.NODE_ENV === 'development') {
    const morgan = require('morgan');
    app.use(morgan('dev'));
}

/* ------------------------------------------------------ */
/*                     API MIDDLEWARES                    */
/* ------------------------------------------------------ */
// API Routes
app.use('/api/v1/pokemons', pokemonRouter);

/* ------------------------------------------------------ */
/*                ERROR HANDLING MIDDLEWARE               */
/* ------------------------------------------------------ */
/* -------------- Non - existing API Routes ------------- */
const ServerError = require('./utils/serverError');
app.use('*', (req, res, next) =>
    next(new ServerError(`Cannot find ${req.originalUrl} on this server`, 404))
);

/* ------------ API Error Centralized Handler ----------- */
const serverErrorHandler = require('./middlewares/serverErrorHandler');
app.use(serverErrorHandler);

/* ------------------------------------------------------ */
/*                         EXPORTS                        */
/* ------------------------------------------------------ */
module.exports = app;
