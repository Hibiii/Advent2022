#ifndef DEFS_H
#define DEFS_H

#define ERR_UNKNOWN_CHAR 1
#define unwrap(A) do {A;} while(0); if(errno)

enum Outcome { Win, Loss, Draw, };
enum Play { Rock, Paper, Scissors, };

extern const int play_score[];

extern const int play_killed_by[];

extern const int play_that_kills[];

extern const int outcome_score[];

#endif
