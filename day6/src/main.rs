use std::fs;

fn are_all_chars_different(chars: &[char]) -> bool {
    let mut seen_chars: Vec<char> = Vec::new();
    for char in chars.iter() {
        if seen_chars.contains(char) {
            return false;
        } else {
            seen_chars.push(*char);
        }
    }
    true
}

fn main() {
    let str = fs::read_to_string("input").unwrap();
    let chars: Vec<char> = str.chars().collect();
    for (index, window) in chars.windows(4).enumerate() {
        if are_all_chars_different(window) {
            println!("Start of packet: {}", index + 4);
            break;
        }
    }
    for (index, window) in chars.windows(14).enumerate() {
        if are_all_chars_different(window) {
            println!("Start of message: {}", index + 14);
            break;
        }
    }
}
