/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';

enum Tone { light, regular, dark }

const Map<String, Map<Tone, Color>> palette = {
  'bug': {
    Tone.light: Color(0xFFC6D16E),
    Tone.regular: Color(0xFFA8B820),
    Tone.dark: Color(0xFF6D7815),
  },
  'dark': {
    Tone.light: Color(0xFFA29288),
    Tone.regular: Color(0xFF705848),
    Tone.dark: Color(0xFF49392F),
  },
  'dragon': {
    Tone.light: Color(0xFFA27DFA),
    Tone.regular: Color(0xFF7038F8),
    Tone.dark: Color(0xFF4924A1),
  },
  'electric': {
    Tone.light: Color(0xFFFAE078),
    Tone.regular: Color(0xFFF8D030),
    Tone.dark: Color(0xFFA1871F),
  },
  'fairy': {
    Tone.light: Color(0xFFF4BDC9),
    Tone.regular: Color(0xFFEE99AC),
    Tone.dark: Color(0xFF9B6470),
  },
  'fighting': {
    Tone.light: Color(0xFFD67873),
    Tone.regular: Color(0xFFC03028),
    Tone.dark: Color(0xFF7D1F1A),
  },
  'fire': {
    Tone.light: Color(0xFFF5AC78),
    Tone.regular: Color(0xFFF08030),
    Tone.dark: Color(0xFF9C531F),
  },
  'flying': {
    Tone.light: Color(0xFFC6B7F5),
    Tone.regular: Color(0xFFA890F0),
    Tone.dark: Color(0xFF6D5E9C),
  },
  'ghost': {
    Tone.light: Color(0xFFA292BC),
    Tone.regular: Color(0xFF705898),
    Tone.dark: Color(0xFF493963),
  },
  'grass': {
    Tone.light: Color(0xFFA7DB8D),
    Tone.regular: Color(0xFF78C850),
    Tone.dark: Color(0xFF4E8234),
  },
  'ground': {
    Tone.light: Color(0xFFEBD69D),
    Tone.regular: Color(0xFFE0C068),
    Tone.dark: Color(0xFF927D44),
  },
  'ice': {
    Tone.light: Color(0xFFBCE6E6),
    Tone.regular: Color(0xFF98D8D8),
    Tone.dark: Color(0xFF638D8D),
  },
  'normal': {
    Tone.light: Color(0xFFC6C6A7),
    Tone.regular: Color(0xFFA8A878),
    Tone.dark: Color(0xFF6D6D4E),
  },
  'poison': {
    Tone.light: Color(0xFFC183C1),
    Tone.regular: Color(0xFFA040A0),
    Tone.dark: Color(0xFF682A68),
  },
  'psychic': {
    Tone.light: Color(0xFFFA92B2),
    Tone.regular: Color(0xFFF85888),
    Tone.dark: Color(0xFFA13959),
  },
  'rock': {
    Tone.light: Color(0xFFD1C17D),
    Tone.regular: Color(0xFFB8A038),
    Tone.dark: Color(0xFF786824),
  },
  'steel': {
    Tone.light: Color(0xFFD1D1E0),
    Tone.regular: Color(0xFFB8B8D0),
    Tone.dark: Color(0xFF787887),
  },
  'water': {
    Tone.light: Color(0xFF9DB7F5),
    Tone.regular: Color(0xFF6890F0),
    Tone.dark: Color(0xFF445E9C),
  },
};
