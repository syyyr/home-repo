use std::collections::HashMap;

fn main()
{
    let mut dict = HashMap::<char, usize>::new();

    String::from("test string").chars().for_each(|x| {
        let item = dict.entry(x).or_insert(0);
        *item = *item + 1;
    });

    println!("{:?}", dict);
}
