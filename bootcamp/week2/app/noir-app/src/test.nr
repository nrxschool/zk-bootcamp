use super::main;

#[test]
fn test_main() {
    main(1997, 2025);
}

#[test(should_fail)]
fn test_minor() {
    main(2020, 2025);
}
