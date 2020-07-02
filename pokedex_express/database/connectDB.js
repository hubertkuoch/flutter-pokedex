/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
const mongoose = require('mongoose');

/* ------------------------------------------------------ */
/*                   Database Connector                   */
/* ------------------------------------------------------ */
const DB_URI = process.env.DATABASE_URI.replace(
    '<password>',
    process.env.DATABASE_PASSWORD
);

const connectOptions = {
    useNewUrlParser: true,
    useFindAndModify: false,
    useCreateIndex: true,
    useUnifiedTopology: true
};

const connectDB = async () => {
    const conn = await mongoose.connect(DB_URI, connectOptions);
    process.env.NODE_ENV === 'development'
        ? console.log(
              '🌟🌟🌟',
              `Connection to ${conn.connection.host} successfull`.black.bgCyan
          )
        : console.log(
              '🌟🌟🌟',
              `Connection to ${conn.connection.host} successful`
          );
};

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = connectDB;
