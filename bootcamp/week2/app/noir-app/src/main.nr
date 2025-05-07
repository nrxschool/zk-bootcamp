mod test;

fn main(birth_year: u16, current_year: u16) {
    assert(current_year - birth_year >= 18);
}
