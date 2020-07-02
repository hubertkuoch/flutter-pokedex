/* ------------------------------------------------------ */
/*     Express.js / MongoDB related custom error class    */
/* ------------------------------------------------------ */
class ServerError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.statusCode = statusCode;
        this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
        this.isOperationalError = true;
        Error.captureStackTrace(this, this.constructor);
    }
}

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = ServerError;
