#![feature(i128_type)]
#![feature(i128)]

extern crate chrono;
extern crate crypto;
extern crate rayon;

use std::u128;
use chrono::prelude::*;
use crypto::md5::Md5;
use crypto::digest::Digest;
use std::io;
use std::io::Write;
use rayon::prelude::*;


struct Block
{
	m_data: String,
	m_timestamp: String,
	m_previous_hash: String,
	m_index: usize,
	m_hash: String,
	m_nonce: usize,
	m_base36: String,
	m_valid: bool
}

fn to_base36(mut num: u128 ) -> String
{
	let chars: String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".to_string();
	
	let mut res: String = "".to_string();
	
	while num > 0
	{
		let index: usize = (num % 36) as usize;
		res = res + chars.chars().nth(index).unwrap().to_string().as_str();
		num = num / 36;
	}
	res
}

impl Block
{
	fn calc_hash(&mut self, cond: String)
	{
		let mut nonce = self.m_nonce; 
		let base = self.m_data.clone() +
		 			  /*self.m_timestamp.to_string().as_str() +*/
					  self.m_previous_hash.as_str() +
					  self.m_index.to_string().as_str();
		let mut hash: String = "".to_string();
		let b36: String;
		loop		
		{
			let mut to_hash: Vec<String> = vec![];
			for i in 0..6
			{
				to_hash.push((base.clone()+(nonce+i).to_string().as_str()));
				
			}
			let hashed: Vec<String> = to_hash.par_iter().map(|ref data| {
				let mut hasher_par = Md5::new();
				hasher_par.input_str(&data); hasher_par.result_str();				
 				hasher_par.result_str()}
			).map(|ref data| {
				to_base36(u128::from_str_radix(&data, 16).unwrap())
				}).collect();
			
			
			match hashed.iter().find(|&item| {&item[..cond.len()] == cond})
			{
				Some(item) => {b36 = item.to_string(); nonce = nonce+hashed.iter().position(|item1| {item1 == item}).unwrap(); break;},
				None => {},
			}
			
			
			//hasher.input_str((base.clone()+nonce.to_string().as_str()).as_str());
			//hash = hasher.result_str();
			nonce = nonce+6;
			//b36 = to_base36(u128::from_str_radix(&hash[..32], 16).unwrap());
		}
		
		if !self.m_valid
		{
			self.m_valid = true;
			self.m_nonce = nonce;
			self.m_hash = hash;
			self.m_base36 = b36[..cond.len()].to_string().to_lowercase() + &b36[cond.len()..];
		}
	}
}

impl std::fmt::Display for Block
{
	fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result 
	{
		write!(f, "Block number {}\nAdded on {}\n", self.m_index, self.m_timestamp)?;
		write!(f, "Data:          {}\n", self.m_data)?;		
		write!(f, "Hash:          {}\n", self.m_hash)?;		
		write!(f, "Nonce:         {}\n", self.m_nonce)?;	
		write!(f, "base36:        {}\n", self.m_base36)/*?;
		write!(f, "Previous hash: {}\n", self.m_previous_hash)*/
		
		
	}
}

struct Blockchain
{
	m_blocks: Vec<Block>,
	m_cond: String,
}

impl Blockchain
{
	fn init(msg: &str, cond: &str) -> Blockchain
	{
		let data = msg.to_string();
		let timestamp = Local::now().format("%d %B %Y %H:%M:%S").to_string();
		let previous_hash = "<initial_block>".to_string();
		let index = 0;
		let mut first_block = Block {
		 m_data: data,
		 m_timestamp: timestamp,
		 m_previous_hash: previous_hash,
		 m_index: index,
		 m_hash: "".to_string(),
		 m_nonce: 0,
 		 m_base36: "".to_string(),
 		 m_valid: false, };
 		first_block.calc_hash(cond.to_string());
		
		
		
		println!("Added a block:\n------------\n{}", first_block);
		Blockchain{m_blocks: vec![first_block], m_cond: cond.to_string()}
	}
	fn add_block(&mut self, msg: &str)
	{
		let data = msg.to_string();
		let timestamp = Local::now().format("%d %B %Y %H:%M:%S").to_string();
		let previous_hash = self.m_blocks.last().unwrap().m_hash.clone();
		let index = self.m_blocks.len();
		let mut block = Block {
		 m_data: data,
		 m_timestamp: timestamp,
		 m_previous_hash: previous_hash,
		 m_index: index,
		 m_hash: "".to_string(),
		 m_nonce: 0,
 		 m_base36: "".to_string(),
 		 m_valid: false, };
 		block.calc_hash(self.m_cond.to_string());
		
		println!("Added a block:\n------------\n{}", block);
		self.m_blocks.push(block);

	}
}

impl std::fmt::Display for Blockchain
{
	fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result 
	{
		write!(f, "Blockchain:\n")?;
		write!(f, "------------\n")?;
		for block in &self.m_blocks
		{
			write!(f, "{}", block)?;
		write!(f, "------------\n")?;
		}
		write!(f, "")
	}
}

fn main()
{
	println!("Welcome to Kekchain!\nInput the condition:");
	print!("> ");
    	io::stdout().flush().ok().expect("Could not flush stdout");
	let mut cond = String::new();
	match io::stdin().read_line(&mut cond) {
    	Ok(_n) => {
        	println!("The condition is set to {}.", &cond[..cond.len()-1].to_lowercase());
		}
    		Err(error) => println!("error: {}", error),
		}
		
	let mut msg = String::new();
	println!("Input the initial block data:");
	print!("> ");
    	io::stdout().flush().ok().expect("Could not flush stdout");
	match io::stdin().read_line(&mut msg) {
    	Ok(_n) => {
        	println!("Initializing the blockchain with \"{}\"", &msg[..msg.len()-1]);
		}
    		Err(error) => println!("error: {}", error),
		}
	let mut chain = Blockchain::init(&msg[..msg.len()-1], &cond[..cond.len()-1].to_uppercase());
	println!("The blockchain is initialized.");
	let mut end = false;
	while !end
	{
		println!("a - add a new block, l - list the blockchain, q - quit ");
		print!("> ");
	    	io::stdout().flush().ok().expect("Could not flush stdout");
		let mut cmd = String::new();
		match io::stdin().read_line(&mut cmd) {
    	Ok(n) => {
    		if n == 1
    		{
    			continue;
    		}
    		if n != 2
    		{
		    	println!("Unrecognized command \"{}\"", cmd);
		    	continue;
    		}
        	match cmd.chars().nth(0).unwrap()
        	{
        		'l' =>
        		{
					println!("{}", chain);		
        		}
        		'a' =>
        		{
    				println!("Input the data for the new block:");
				print!("> ");
			    	io::stdout().flush().ok().expect("Could not flush stdout");
    				let mut input = String::new();
					match io::stdin().read_line(&mut input) {
						Ok(_n) => {
				        		println!("Adding a new block with \"{}\"", &input[..input.len()-1]);
							chain.add_block(&input[..input.len()-1])
						}
							Err(error) => println!("error: {}", error),
						}
        		}
        		'q' => end = true,
	    		_ => println!("Unrecognized command \"{}\"", cmd),
        	}
		}
    		Err(error) => println!("error: {}", error),
		}	
	}
	println!("Bye xd!");
}	
	
	
	
