use std::{env, fs};

use file_decoder::{decode_stack, run_ins_listing};

mod file_decoder;

fn main() {
    let grouping_move = {
        let t0: Vec<String> = env::args().collect();
        t0.contains(&"use-grouping-move".to_string())
    };
    let input = fs::read_to_string("input").unwrap();
    let mut field = decode_stack(&input);
    run_ins_listing(&input, &mut field, grouping_move);
    for stack in field {
        for cr8 in stack {
            print!("[{}]", cr8);
        }
        print!("\n");
    }
}
