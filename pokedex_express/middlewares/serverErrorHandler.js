/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
const ServerError = require('../utils/serverError');

/* ------------------------------------------------------ */
/*                    Development Mode                    */
/* ------------------------------------------------------ */
const handleDevelopmentError = (err, res) => {
    res.status(err.statusCode).json({
        status: err.status,
        message: err.message,
        error: err,
        stack: err.stack
    });
};

/* ------------------------------------------------------ */
/*                     Production Mode                    */
/* ------------------------------------------------------ */
// MongoDB/Mongoose model validation error
const handleMongooseValidationError = (error) => {
    const errors = Object.values(error.errors).map((val) => val.message);
    const message = `Invalid input data. ${errors.join('. ')}`;
    return new ServerError(message, 400);
};

// MongoDB/Mongoose model field unicity error
const handleMongooseUniqueError = (error) => {
    const errorKeys = Object.keys(error.keyValue);
    const message = `Duplicate field value: ${errorKeys.join(
        '. '
    )}. Please use different value(s)`;
    return new ServerError(message, 400);
};

// MongoDB/Mongoose cast Id error
const handleMongooseCastIDError = (error) => {
    const message = `Invalid ${error.path}: ${error.value}`;
    return new ServerError(message, 400);
};

// Consolidated
const handleProductionError = (err, res) => {
    let error = { ...err };
    error.message = err.message;

    if (error.name === 'ValidationError')
        error = handleMongooseValidationError(error);
    if (error.code === 11000) error = handleMongooseUniqueError(error);
    if (error.name === 'CastError') error = handleMongooseCastIDError(error);

    error.isOperationalError
        ? res.status(error.statusCode).json({
              status: error.status,
              message: error.message
          })
        : res.status(error.statusCode).json({
              status: 'error',
              message: 'Sorry, something went wrong...'
          });
};

/* ------------------------------------------------------ */
/*   Express.js custom server centralized error handler   */
/* ------------------------------------------------------ */
const serverErrorHandler = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    process.env.NODE_ENV !== 'production'
        ? handleDevelopmentError(err, res)
        : handleProductionError(err, res);
};

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = serverErrorHandler;
