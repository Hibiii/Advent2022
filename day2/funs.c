#include "funs.h"
#include <errno.h>
#include "defs.h"

// uses errno
enum Play play_from_char(char character) {
	errno = 0;
	switch (character) {
		case 'A': return Rock;
		case 'B': return Paper;
		case 'C': return Scissors;
		default:
			errno = ERR_UNKNOWN_CHAR;
			return Rock;
	}
}

// uses errno
enum Play guess_play_from_char(char character) {
	errno = 0;
	switch (character) {
		case 'X': return Rock;
		case 'Y': return Paper;
		case 'Z': return Scissors;
		default:
			errno = ERR_UNKNOWN_CHAR;
			return Rock;
	}
}

// uses errno
enum Outcome outcome_from_char(char character) {
	errno = 0;
	switch (character) {
		case 'X': return Loss;
		case 'Y': return Draw;
		case 'Z': return Win;
		default:
			errno = ERR_UNKNOWN_CHAR;
			return Draw;
	}
}

enum Outcome compare_play(enum Play opponents, enum Play yours) {
	if(opponents == yours) return Draw;
	if(play_killed_by[opponents] == yours) return Loss;
	return Win;
}

enum Play fix_match(enum Play opponents, enum Outcome desired) {
	switch(desired) {
		case Win: return play_that_kills[opponents];
		case Loss: return play_killed_by[opponents];
		case Draw: return opponents;
	}
}

int get_round_score(enum Play opponents, enum Play yours) {
	return outcome_score[compare_play(opponents, yours)] + play_score[yours];
}
