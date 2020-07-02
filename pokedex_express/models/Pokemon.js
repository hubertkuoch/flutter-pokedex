/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
const mongoose = require('mongoose');

/* ------------------------------------------------------ */
/*                         Schema                         */
/* ------------------------------------------------------ */
const pokemonSchema = mongoose.Schema(
    {
        number: {
            type: Number,
            unique: true,
            required: [true, 'Pokemon must have an order number']
        },
        name: {
            type: String,
            unique: true,
            required: [true, 'Pokemon must have a name']
        },
        types: [
            {
                type: String,
                required: [true, 'Pokemon must have at least one type']
            }
        ],
        abilities: [String],
        imageURL: {
            type: String,
            unique: true,
            required: [true, 'Pokemon must have an imageURL']
        },
        height: {
            type: Number,
            required: [true, 'Pokemon must have a height']
        },
        weight: {
            type: Number,
            required: [true, 'Pokemon must have a weight']
        },
        eggGroups: [String],
        description: {
            type: String,
            required: [true, 'Pokemon must have a description']
        },
        locations: [String],
        habitat: String,
        captureRate: Number,
        genderRate: {
            male: Number,
            female: Number
        },
        generation: {
            type: Number,
            required: [true, 'Pokemon must belong to a generation']
        },
        evolutionChain: [
            [
                {
                    _id: false,
                    name: String,
                    level: Number,
                    item: String
                }
            ]
        ],
        stats: {
            attack: {
                type: Number,
                min: [0, 'Attack stat must be above 0'],
                required: [true, 'Pokemon must have an attack stat']
            },
            defense: {
                type: Number,
                min: [0, 'Defense stat must be above 0'],
                required: [true, 'Pokemon must have a defense stat']
            },
            hp: {
                type: Number,
                min: [0, 'HP stat must be above 0'],
                required: [true, 'Pokemon must have a HP stat']
            },
            speed: {
                type: Number,
                min: [0, 'Speed stat must be above 0'],
                required: [true, 'Pokemon must have a speed stat']
            },
            specialAttack: {
                type: Number,
                min: [0, 'Special attack stat must be above 0'],
                required: [true, 'Pokemon must have a special attack stat']
            },
            specialDefense: {
                type: Number,
                min: [0, 'Special defense stat must be above 0'],
                required: [true, 'Pokemon must have a special defense stat']
            }
        },
        createdAt: {
            type: Date,
            default: Date.now,
            select: false
        }
    },
    {
        versionKey: false
    }
);

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
const Pokemon = mongoose.model('Pokemon', pokemonSchema);
module.exports = Pokemon;
