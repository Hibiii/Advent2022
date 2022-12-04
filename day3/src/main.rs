use std::fs;

use itertools::Itertools;

#[derive(Debug)]
enum Errors {
    NotAlphabetic,
}

fn priority_from_char(char: char) -> Result<u32, Errors> {
    if !char.is_alphabetic() {
        return Err(Errors::NotAlphabetic);
    }
    let out = if char.is_uppercase() {
        char as u32 - 'A' as u32 + 27
    } else {
        char as u32 - 'a' as u32 + 1
    };
    Ok(out)
}

fn find_sum_of_priority_dupes(input: &String) -> i32 {
    let mut accumulator = 0;

    for line in input.lines() {
        let (left, right) = line.split_at(line.len() / 2);
        let old_accum = accumulator;

        for char in left.chars() {
            if right.contains(char) {
                accumulator += priority_from_char(char).unwrap();
                break;
            }
        }
        if old_accum == accumulator {
            panic!("line without dupes")
        }
    }

    accumulator as i32
}

fn search_for_badge(input: &String) -> i32 {
    let mut accumulator = 0;
    for mut lines in &input.lines().chunks(3) {
        let line_1 = lines.next().unwrap();
        let line_2 = lines.next().unwrap();
        let line_3 = lines.next().unwrap();
        for char in line_1.chars() {
            if line_2.contains(char) && line_3.contains(char) {
                accumulator += priority_from_char(char).unwrap();
                break;
            }
        }
    }
    accumulator as i32
}

fn main() {
    let input = fs::read_to_string("input").expect("no input file named \"input\"");
    println!(
        "Sum of priorities of dupes: {}\nSum of the priorities of what could possibly be badges: {}",
        find_sum_of_priority_dupes(&input), search_for_badge(&input));
}
