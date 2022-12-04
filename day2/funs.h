#ifndef FUNS_H
#define FUNS_H

#include "defs.h"

// uses errno
enum Play play_from_char(char character);

// uses errno
enum Play guess_play_from_char(char character);

// uses errno
enum Outcome outcome_from_char(char character);

enum Outcome compare_play(enum Play opponents, enum Play yours);

enum Play fix_match(enum Play opponents, enum Outcome desired);

int get_round_score(enum Play opponents, enum Play yours);

#endif
