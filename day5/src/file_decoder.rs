use regex::Regex;

type Crate = char;
type Stack = Vec<Crate>;
type StackField = Vec<Stack>;

struct MoveInstruction {
    crates: i32,
    origin: usize,
    destination: usize,
}
impl MoveInstruction {
    fn new(crates: i32, origin: usize, destination: usize) -> Self {
        MoveInstruction {
            crates,
            origin: origin - 1,
            destination: destination - 1,
        }
    }
    fn enact(&self, stack_field: &mut StackField) {
        for _ in 0..self.crates {
            let picked_up = stack_field.get_mut(self.origin).unwrap().pop().unwrap();
            stack_field
                .get_mut(self.destination)
                .unwrap()
                .push(picked_up);
        }
    }
    fn enact_grouping(&self, stack_field: &mut StackField) {
        let mut temp_stack = Stack::new();
        for _ in 0..self.crates {
            let picked_up = stack_field.get_mut(self.origin).unwrap().pop().unwrap();
            temp_stack.push(picked_up);
        }
        for i in temp_stack.iter().rev() {
            stack_field.get_mut(self.destination).unwrap().push(*i);
        }
    }
}

pub fn decode_stack(input: &String) -> StackField {
    let mut empty_line_index = 0;
    let mut out = StackField::new();
    for (i, line) in input.lines().enumerate() {
        if line.is_empty() {
            empty_line_index = i;
            break;
        }
    }

    let lines: Vec<&str> = input.lines().take(empty_line_index).collect();
    let rex = Regex::new(r"(\d+)").unwrap();
    let mut columns = Vec::<usize>::new();
    for mat in rex.find_iter(lines.last().unwrap()) {
        columns.push(mat.start());
        out.push(Vec::new());
    }
    for line in lines.iter().rev().skip(1) {
        for (i, col) in columns.iter().enumerate() {
            let c = line.chars().nth(*col);
            let c = if c.is_some() && c.unwrap().is_alphabetic() {
                c.unwrap()
            } else {
                continue;
            };
            out.get_mut(i).unwrap().push(c);
        }
    }
    out
}

pub fn run_ins_listing(input: &String, stack_field: &mut StackField, use_grouping_move: bool) {
    let mut empty_line_index = 0;
    for (i, line) in input.lines().enumerate() {
        if line.is_empty() {
            empty_line_index = i;
            break;
        }
    }
    let rex =
        Regex::new(r"move (?P<crates>\d+) from (?P<origin>\d+) to (?P<destination>\d+)").unwrap();
    let lines = input.lines().skip(empty_line_index + 1);
    for line in lines {
        let caps = rex.captures(line).unwrap();
        let crates: i32 = caps["crates"].parse().unwrap();
        let origin: usize = caps["origin"].parse().unwrap();
        let destination: usize = caps["destination"].parse().unwrap();
        let move_ins = MoveInstruction::new(crates, origin, destination);
        if use_grouping_move {
            move_ins.enact_grouping(stack_field);
        } else {
            move_ins.enact(stack_field);
        }
    }
}
