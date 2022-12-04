use std::fs;

use regex::Regex;

struct CleaningRange {
    start: i32,
    end: i32,
}
impl CleaningRange {
    fn new(start: i32, end: i32) -> Self {
        Self { start, end }
    }
    fn completely_overlaps(&self, other: &Self) -> bool {
        self.start <= other.start && self.end >= other.end
    }
    fn partially_overlaps(&self, other: &Self) -> bool {
        self.start <= other.end && self.end >= other.start
    }
}
impl std::fmt::Display for CleaningRange {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "[{}, {}]", self.start, self.end)
    }
}

fn main() {
    let input = fs::read_to_string("input").expect("no input file named \"input\"");
    let rex = Regex::new(
        r"(?P<start_left>\d+)-(?P<end_left>\d+),(?P<start_right>\d+)-(?P<end_right>\d+)",
    )
    .unwrap();
    let mut complete_overlaps = 0;
    let mut partial_overlaps = 0;
    for line in input.lines() {
        let captures = rex.captures(line);
        if captures.is_none() {
            continue;
        };
        let captures = captures.unwrap();
        let range_left = CleaningRange::new(
            *(&captures["start_left"].parse().unwrap()),
            *(&captures["end_left"].parse().unwrap()),
        );
        let range_right = CleaningRange::new(
            *(&captures["start_right"].parse().unwrap()),
            *(&captures["end_right"].parse().unwrap()),
        );
        if range_left.completely_overlaps(&range_right)
            || range_right.completely_overlaps(&range_left)
        {
            complete_overlaps += 1;
        }
        if range_left.partially_overlaps(&range_right) {
            partial_overlaps += 1;
        }
    }
    println!(
        "Complete overlaps: {}\nPartial overlaps: {}",
        complete_overlaps, partial_overlaps
    );
}
