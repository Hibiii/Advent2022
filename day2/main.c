#include <stdio.h>
#include <errno.h>

#include "defs.h"
#include "funs.h"

int main(int argc, char *argv[]) {
	if (argc != 1) {
		fprintf(stderr, "err: takes no args, only stdin");
		return 1;
	}
	int lines = 0;
	int score_by_guessing = 0;
	int score_by_fixing = 0;
	char left = 0, right = 0;
	while(!feof(stdin)) {
		enum Play opponents, yours;
		enum Outcome desired;
		/* reading */ {
			lines++;
			scanf("%c %c\n", &left, &right);
			unwrap(opponents = play_from_char(left)) {
				fprintf(stderr, "err: unknown char on left: %c, line %d\n", left, lines);
				return 1;
			}
			unwrap(yours = guess_play_from_char(right)) {
				fprintf(stderr, "err: guessing: unknown char on right: %c, line %d\n", right, lines);
				return 1;
			}
			unwrap(desired = outcome_from_char(right)) {
				fprintf(stderr, "err: fixinng: unknown char on right: %c, line %d\n", right, lines);
				return 1;
			}
		}
		/* scoring */ {
			score_by_guessing += get_round_score(opponents, yours);
			score_by_fixing += get_round_score(opponents, fix_match(opponents, desired));
		}
	}
	fprintf(stderr, "info: read %d lines\n", lines);
	fprintf(stdout, "Score if guessing: %d\n", score_by_guessing);
	fprintf(stdout, "Score if match fixing: %d\n", score_by_fixing);
	return 0;
}