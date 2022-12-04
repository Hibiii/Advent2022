#include "defs.h"

const int play_score[] = {
    [Rock] = 1, [Paper] = 2, [Scissors] = 3,
};

const int play_killed_by[] = {
	[Rock] = Scissors, [Paper] = Rock, [Scissors] = Paper,
};

const int play_that_kills[] = {
	[Rock] = Paper, [Paper] = Scissors, [Scissors] = Rock,
};

const int outcome_score[] = {
	[Win] = 6, [Loss] = 0, [Draw] = 3,
};