/* ------------------------------------------------------ */
/*         MongoDB / Mongoose index query specific        */
/* ------------------------------------------------------ */
class IndexQuery {
    constructor(query, queryOptions) {
        this.query = query;
        this.queryOptions = queryOptions;
    }

    /* ----------------------- Filter ----------------------- */
    filter() {
        // Exclude sort, select, and paginate query object keys
        const queryOptions = { ...this.queryOptions };
        const excludedFields = ['sort', 'select', 'page', 'limit'];
        excludedFields.forEach((field) => delete queryOptions[field]);

        // Convert "greater/lower than" query object keys into
        // MongoDB/Mongoose query language
        let queryString = JSON.stringify(queryOptions);
        queryString = queryString.replace(
            /\b(gte|gt|lte|lt)\b/g,
            (match) => `$${match}`
        );
        this.query = this.query.find(JSON.parse(queryString));
        return this;
    }

    /* ----------------------- Select ----------------------- */
    select() {
        // If query options object has "select" key, chain select request
        if (this.queryOptions.select) {
            const queryString = this.queryOptions.select.split(',').join(' ');
            this.query = this.query.select(queryString);
        }
        return this;
    }

    /* ------------------------ Sort ------------------------ */
    sort() {
        // If query options object has a "sort" key, chain sort request
        if (this.queryOptions.sort) {
            const queryString = this.queryOptions.sort.split(',').join(' ');
            this.query = this.query.sort(queryString);
        } else {
            // This is a default sorting criteria based on pokemon order
            // This can be removed
            this.query = this.query.sort('number');
        }
        return this;
    }

    /* ---------------------- Paginate ---------------------- */
    paginate() {
        const page = this.queryOptions.page * 1 || 1;
        const limit = this.queryOptions.limit * 1 || 807;
        const skip = (page - 1) * limit;
        this.query = this.query.skip(skip).limit(limit);
        return this;
    }
}

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = IndexQuery;
