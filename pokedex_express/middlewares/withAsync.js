/* ------------------------------------------------------ */
/*        Wrapper for async / await try/catch block       */
/* ------------------------------------------------------ */
const withAsync = (_function) => (req, res, next) =>
    _function(req, res, next).catch(next);

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = withAsync;
