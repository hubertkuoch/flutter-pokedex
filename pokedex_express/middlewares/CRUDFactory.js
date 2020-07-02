/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
/* ---------------------- internal ---------------------- */
const withAsync = require('./withAsync');
const IndexQuery = require('../utils/indexQuery');
const ServerError = require('../utils/serverError');

/* ------------------------------------------------------ */
/*                      CRUD Factory                      */
/* ------------------------------------------------------ */
/* ------------------------ Index ----------------------- */
const getAll = (Model) =>
    withAsync(async (req, res, next) => {
        const request = new IndexQuery(Model.find(), req.query)
            .filter()
            .sort()
            .select()
            .paginate();
        const results = await request.query;
        res.status(200).json({
            status: 'success',
            count: results.length,
            data: results
        });
    });

/* ------------------------ Show ------------------------ */
const getOne = (Model) =>
    withAsync(async (req, res, next) => {
        const result = await Model.findOne({ name: req.params.name });

        if (!result)
            return next(
                new ServerError(
                    `No ${Model.collection.collectionName} found with that name`,
                    404
                )
            );

        res.status(200).json({
            status: 'success',
            data: result
        });
    });

/* ----------------------- Create ----------------------- */
const createOne = (Model) =>
    withAsync(async (req, res, next) => {
        const newRecord = await Model.create(req.body);

        res.status(200).json({
            status: 'success',
            data: newRecord
        });
    });

/* ----------------------- Update ----------------------- */
const updateOne = (Model) =>
    withAsync(async (req, res, next) => {
        const updatedRecord = await Model.findByIdAndUpdate(
            req.params.id,
            req.body,
            {
                new: true,
                runValidators: true
            }
        );

        if (!updatedRecord)
            return next(
                new ServerError(
                    `No ${Model.collection.collectionName} found with that ID`,
                    404
                )
            );

        res.status(200).json({
            status: 'success',
            data: updatedRecord
        });
    });

/* ----------------------- Delete ----------------------- */
const deleteOne = (Model) =>
    withAsync(async (req, res, next) => {
        const deletedRecord = await Model.findByIdAndDelete(req.params.id);

        if (!deletedRecord)
            return next(
                new ServerError(
                    `No ${Model.collection.collectionName} found with that ID`,
                    404
                )
            );

        res.status(200).json({
            status: 'success',
            data: deletedRecord
        });
    });

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = { getAll, getOne, createOne, updateOne, deleteOne };
