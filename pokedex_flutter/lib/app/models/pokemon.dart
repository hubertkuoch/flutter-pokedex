/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/foundation.dart';

class GenderRate {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final dynamic male;
  final dynamic female;

  GenderRate({this.male, this.female});

  // named factory constructor (from Json to model)
  factory GenderRate.fromMap(Map<String, dynamic> parsedJson) {
    return GenderRate(
      male: parsedJson['male'],
      female: parsedJson['female'],
    );
  }
}

class Stats {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final int attack, defense, hp, speed, specialAttack, specialDefense;

  Stats({
    this.attack,
    this.defense,
    this.hp,
    this.speed,
    this.specialAttack,
    this.specialDefense,
  });

  // named factory constructor (from Json to model)
  factory Stats.fromMap(Map<String, dynamic> parsedJson) {
    return Stats(
      attack: parsedJson['attack'],
      defense: parsedJson['defense'],
      hp: parsedJson['hp'],
      speed: parsedJson['speed'],
      specialAttack: parsedJson['specialAttack'],
      specialDefense: parsedJson['specialDefense'],
    );
  }
}

class EvolutionStage {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final String name;
  final int level;
  final String item;

  EvolutionStage({this.name, this.level, this.item});

  // named factory constructor (from Json to model)
  factory EvolutionStage.fromMap(Map<String, dynamic> parsedJson) {
    return EvolutionStage(
      name: parsedJson['name'],
      level: parsedJson['level'],
      item: parsedJson['item'],
    );
  }
}

class EvolutionChain {
  /* ----------------- Instance Variables ----------------- */
  // constructor - from and to as dynamic - to handle String and Pokemon types)
  final dynamic from, to;
  final int level;
  final String item;

  EvolutionChain({this.from, this.to, this.item, this.level});

  // static helper to return List<EvolutionChain>
  static List<EvolutionChain> fromEvolutionStageList(
      List<dynamic> evolutionStageList) {
    final List<EvolutionChain> evolutions = [];
    for (var i = 0; i < evolutionStageList.length - 1; i++) {
      for (var j = 0; j < evolutionStageList[i].length; j++) {
        for (var k = 0; k < evolutionStageList[i + 1].length; k++) {
          evolutions.add(EvolutionChain(
            from: evolutionStageList[i][j].name,
            to: evolutionStageList[i + 1][k].name,
            level: evolutionStageList[i + 1][k].level,
            item: evolutionStageList[i + 1][k].item,
          ));
        }
      }
    }
    return evolutions;
  }
}

class Pokemon {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final int number, height, weight, generation;
  final String name, imageURL, description, habitat;
  final List<String> types, abilities, eggGroups, locations;
  final double captureRate;
  final GenderRate genderRate;
  final Stats stats;
  final List<dynamic> evolutionChain;

  Pokemon({
    @required this.number,
    this.height,
    this.weight,
    this.generation,
    @required this.name,
    @required this.imageURL,
    this.description,
    this.habitat,
    this.types,
    this.abilities,
    this.eggGroups,
    this.locations,
    this.captureRate,
    this.genderRate,
    this.stats,
    this.evolutionChain,
  }) : assert(number != null && name != null && imageURL != null);

  // named factory constructor (from Json to model)
  factory Pokemon.fromMap(Map<String, dynamic> parsedJson) {
    return Pokemon(
      number: parsedJson['number'],
      name: parsedJson['name'],
      types: List<String>.from(parsedJson['types']),
      abilities: List<String>.from(parsedJson['abilities']),
      imageURL: parsedJson['imageURL'],
      height: parsedJson['height'],
      weight: parsedJson['weight'],
      eggGroups: List<String>.from(parsedJson['eggGroups']),
      description: parsedJson['description'],
      locations: List<String>.from(parsedJson['locations']),
      habitat: parsedJson['habitat'],
      captureRate: parsedJson['captureRate'].toDouble(),
      generation: parsedJson['generation'],
      genderRate: GenderRate.fromMap(parsedJson['genderRate']),
      stats: Stats.fromMap(parsedJson['stats']),
      evolutionChain: EvolutionChain.fromEvolutionStageList(
        parsedJson['evolutionChain']
            .map((stage) => stage
                .map((evolution) => EvolutionStage.fromMap(evolution))
                .toList())
            .toList(),
      ),
    );
  }
}
