drop database if exists cooking_contest;
create database cooking_contest;
use cooking_contest;

create table recipes (		
	recipe_name 	varchar(50),
	difficulty		int check(difficulty between 1 and 5),
	description		varchar(255),
	pastry_or_not	bit,
	nationality		varchar(20) not null,
	prep_time		time not null,
	cooking_time	time not null,
	portions		int check(portions > 0),
	recipe_pic		blob,
	primary key(recipe_name),
	check(nationality in ('American', 'Arab', 'Argentine', 'Armenian', 'Belgian', 'British', 'Chinese', 'Egyptian', 
							'Filipino', 'French', 'Greek', 'Hungarian', 'Indian', 'Indonesian', 'Italian', 'Japanese',
							'Korean', 'Mexican', 'Moroccan', 'Pakistani', 'Palestinian', 'Russian', 'Spanish')) 
);

-- meal_type is a multivariable attribute of recipes

create table meal_type (	
	m_type			enum('Breakfast', 'Supper', 'Dessert', 'Soup', 'Lunch', 'Elevenses', 'Salad', 'Dinner', 'Snack'),
	recipe_name		varchar(50),
	primary key(m_type, recipe_name),
	constraint recipe_type foreign key(recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade
);

-- meal_tag is a multivariable attribute of recipes

create table meal_tag (		
	tag				varchar(20),
	recipe_name		varchar(50),
	primary key(tag, recipe_name),
	check(tag in ('Brunch', 'Quick Lunch', 'Appetiser', 'Cold Dish', 'Refreshment', 'Spicy', 'Warm Dish', 'Salty',
					'Sweet and Sour', 'Sweet', 'Winter Dish', 'Summer Dish')),
	constraint recipe_tag foreign key(recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade
);

-- tips is a multivariable attribute of recipes

create table tips (		
	recipe_name		varchar(50),
	tip_id			int check(tip_id between 1 and 3),
	tip				varchar(255),
	primary key(recipe_name, tip_id,tip),
	constraint unigue_tip_id_per_recipe unique(recipe_name,tip_id),
	constraint unigue_tip_per_recipe unique(recipe_name,tip),
	constraint recipe_tips foreign key(recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade
);

-- rec_steps is a multivariable attribute of recipes

create table rec_steps (	
	recipe_name		varchar(50),
	exec_number		int check(exec_number > 0),
	step_desc		varchar(255),
	primary key(recipe_name, exec_number, step_desc),
	constraint unigue_exec_number_per_recipe unique(recipe_name,exec_number),
	constraint unigue_step_desc_per_recipe unique(recipe_name,step_desc),
	constraint recipe_steps foreign key(recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade
);

create table cooking_gear (	
	gear_name		varchar(50),
	gear_desc		varchar(255),
	gear_pic		blob,
	primary key(gear_name)
);

-- demands is a relationship between recipes and cooking_gear: Many to Many

create table demands (		
	recipe_name		varchar(50),
	gear_name		varchar(30),
	primary key(recipe_name, gear_name),
	constraint demands_recipe foreign key (recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade,
	constraint demands_cooking_gear foreign key (gear_name) references cooking_gear(gear_name)
		on delete cascade
		on update cascade
);

create table theme_category (	
	theme_name		varchar(40),
	theme_desc		varchar(255),
	theme_pic		blob,
	primary key(theme_name)
);

-- belongs_to is a relationship between recipes and theme_category: Many to Many

create table belongs_to (	
	recipe_name		varchar(50),
	theme_name		varchar(40),
	primary key(recipe_name, theme_name),
	constraint belongs_to_recipe foreign key (recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade,
	constraint belongs_to_theme_category foreign key (theme_name) references theme_category(theme_name)
		on delete cascade
		on update cascade 
);

create table ingredients (	
	ing_name		varchar(30),
	fats			numeric(5, 0) default(0) check(fats >= 0),
	carbs			numeric(5, 0) default(0) check(carbs >= 0),
	protein			numeric(5, 0) default(0) check(protein >= 0),
	ing_pic			blob,
	primary key(ing_name)
);

-- contain is a relationship between recipes and ingredients: Many to Many

create table contain (		
	recipe_name		varchar(50),
	ing_name		varchar(30),
	quantity		real check(quantity > 0),
	primary key(recipe_name, ing_name),
	constraint contain_recipe foreign key (recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade,
	constraint contain_ingredients foreign key (ing_name) references ingredients(ing_name)
		on delete cascade
		on update cascade
);

create table food_group (	
	group_name		varchar(30),
	group_desc		varchar(255),
	group_pic		blob,
	primary key(group_name),
	check(group_name in ('Coffee, Tea and more', 'Canned Foods', 'Sweetening Agents', 'Fats and Oils', 'Eggs and Diary Products',
							'Red Meat', 'White Meat', 'Fish', 'Sea Food', 'Cereals and Potatoes', 'Vegetables', 'Alcoholic products',
							'Fruits', 'Legumes', 'Nuts', 'Misc'))
);

-- has_group is a relationship between ingredients and food_group: Many to One

create table has_group (	
	group_name		varchar(30),
	ing_name		varchar(30),
	primary key(ing_name),
	foreign key (group_name) references food_group(group_name)
		on delete cascade
		on update cascade,
	foreign key (ing_name) references ingredients(ing_name)
		on delete cascade
		on update cascade
);

-- basic_ingredient is a relationship between recipes and ingredients: Many to One, kind()

create table basic_ingredient (	
	recipe_name		varchar(50),
	ing_name		varchar(30),
	primary key(recipe_name),
	foreign key (recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade,
	foreign key (ing_name) references ingredients(ing_name)
		on delete cascade
		on update cascade 
);

create table cooks (		
	cook_id			int,
	first_name		varchar(50) not null,
	last_name		varchar(50) not null,
	birth_date		date not null,
	work_exp		int check(work_exp >= 0),
	ranks			enum('a_cook', 'b_cook', 'c_cook', 'sous_chef', 'chef'),
	cook_pic		blob,
	primary key(cook_id)
);

create table episode (		
	serial_number	int check(serial_number between 1 and 10),
	contest_year	numeric(4, 0) check(contest_year between 2024 and 9999),
	ep_pic			blob,
	primary key(serial_number, contest_year)
);

-- phone_number is a multivariable attribute of cooks

create table phone_number (	
	cook_id			int,
	phone_num		numeric(15, 0),
	primary key(cook_id, phone_num),
	constraint cooks_phone_num foreign key(cook_id) references cooks(cook_id)
		on delete cascade
		on update cascade
);

-- expertise is a multivariable attribute of cooks

create table expertise (	
	cook_id			int,
	cuisine 		varchar(30),
	primary key(cook_id, cuisine),
	constraint cooks_expertise foreign key(cook_id) references cooks(cook_id)
		on delete cascade
		on update cascade,
	check(cuisine in ('American', 'Arab', 'Argentine', 'Armenian', 'Belgian', 'British', 'Chinese', 'Egyptian', 
							'Filipino', 'French', 'Greek', 'Hungarian', 'Indian', 'Indonesian', 'Italian', 'Japanese',
							'Korean', 'Mexican', 'Moroccan', 'Pakistani', 'Palestinian', 'Russian', 'Spanish'))
);

-- judge is a specialization of cooks

create table judge (	
	cook_id 		int,
	judge_id 		int check(judge_id between 1 and 3),
	serial_number 	int,
	contest_year 	numeric(4, 0),
	primary key(cook_id, serial_number, contest_year),
	constraint unique_judge_id_per_episode unique(judge_id, serial_number, contest_year),
	constraint judge_is_a_cook foreign key(cook_id) references cooks(cook_id)
		on delete cascade
		on update cascade,
	constraint judge_in_episode foreign key(serial_number, contest_year) references episode(serial_number, contest_year)
		on delete cascade
		on update cascade
);

-- participant is a specialization of cooks

create table participant (	
	cook_id 		int,
	part_id			int check(part_id between 1 and 10),
	serial_number 	int,
	contest_year 	numeric(4, 0),
	primary key(cook_id, serial_number, contest_year),
	constraint unique_part_id_per_episode unique(part_id, serial_number, contest_year),
	constraint participant_is_a_cook foreign key(cook_id) references cooks(cook_id)
		on delete cascade
		on update cascade,
    	constraint participant_in_episode foreign key(serial_number, contest_year) references episode(serial_number,contest_year)
		on delete cascade
		on update cascade
);

-- has_to_cook is a relationship among participant, recipes and episode

create table has_to_cook (	
	recipe_name		varchar(50),
	cook_id			int,
	serial_number	int,
	contest_year 	numeric(4, 0),
	primary key(cook_id, serial_number, contest_year),
	constraint has_to_cook_recipe foreign key(recipe_name) references recipes(recipe_name)
		on delete cascade
		on update cascade,
	constraint has_to_cook_participant foreign key(cook_id, serial_number, contest_year) references participant(cook_id, serial_number, contest_year)
		on delete cascade
		on update cascade
);

-- grades is a relationship among judge, participant and episode

create table grades (		
	judge_cook_id 	int,
	part_cook_id 	int,
	serial_number 	int,
	contest_year 	numeric(4, 0),
	grade 			int check(grade between 1 and 5),
	primary key(judge_cook_id, part_cook_id, serial_number, contest_year),
	constraint grades_participant foreign key(part_cook_id, serial_number, contest_year) references participant(cook_id, serial_number, contest_year)
		on delete cascade
		on update cascade,
	constraint grades_judge foreign key(judge_cook_id, serial_number, contest_year) references judge(cook_id, serial_number, contest_year)
		on delete cascade
		on update cascade
);

-- Views for each cook

create view cook1_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 1
order by
	htc.cook_id;

create view cook2_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 2
order by
	htc.cook_id;

create view cook3_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 3
order by
	htc.cook_id;

create view cook4_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 4
order by
	htc.cook_id;

create view cook5_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 5
order by
	htc.cook_id;

create view cook6_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 6
order by
	htc.cook_id;

create view cook7_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 7
order by
	htc.cook_id;

create view cook8_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 8
order by
	htc.cook_id;

create view cook9_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 9
order by
	htc.cook_id;

create view cook10_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 10
order by
	htc.cook_id;

create view cook11_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 11
order by
	htc.cook_id;

create view cook12_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 12
order by
	htc.cook_id;

create view cook13_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 13
order by
	htc.cook_id;

create view cook14_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 14
order by
	htc.cook_id;

create view cook15_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 15
order by
	htc.cook_id;

create view cook16_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 16
order by
	htc.cook_id;

create view cook17_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 17
order by
	htc.cook_id;

create view cook18_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 18
order by
	htc.cook_id;

create view cook19_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 19
order by
	htc.cook_id;

create view cook20_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 20
order by
	htc.cook_id;

create view cook21_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 21
order by
	htc.cook_id;

create view cook22_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 22
order by
	htc.cook_id;

create view cook23_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 23
order by
	htc.cook_id;

create view cook24_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 24
order by
	htc.cook_id;

create view cook25_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 25
order by
	htc.cook_id;

create view cook26_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 26
order by
	htc.cook_id;

create view cook27_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 27
order by
	htc.cook_id;

create view cook28_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 28
order by
	htc.cook_id;

create view cook29_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 29
order by
	htc.cook_id;

create view cook30_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 30
order by
	htc.cook_id;

create view cook31_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 31
order by
	htc.cook_id;

create view cook32_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 32
order by
	htc.cook_id;

create view cook33_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 33
order by
	htc.cook_id;

create view cook34_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 34
order by
	htc.cook_id;

create view cook35_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 35
order by
	htc.cook_id;

create view cook36_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 36
order by
	htc.cook_id;

create view cook37_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 37
order by
	htc.cook_id;

create view cook38_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 38
order by
	htc.cook_id;

create view cook39_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 39
order by
	htc.cook_id;

create view cook40_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 40
order by
	htc.cook_id;

create view cook41_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 41
order by
	htc.cook_id;

create view cook42_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 42
order by
	htc.cook_id;

create view cook43_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 43
order by
	htc.cook_id;

create view cook44_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 44
order by
	htc.cook_id;

create view cook45_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 45
order by
	htc.cook_id;

create view cook46_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 46
order by
	htc.cook_id;

create view cook47_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 47
order by
	htc.cook_id;

create view cook48_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 48
order by
	htc.cook_id;

create view cook49_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 49
order by
	htc.cook_id;

create view cook50_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 50
order by
	htc.cook_id;

create view cook51_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 51
order by
	htc.cook_id;

create view cook52_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 52
order by
	htc.cook_id;

create view cook53_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 53
order by
	htc.cook_id;

create view cook54_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 54
order by
	htc.cook_id;

create view cook55_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 55
order by
	htc.cook_id;

create view cook56_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 56
order by
	htc.cook_id;

create view cook57_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 57
order by
	htc.cook_id;

create view cook58_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 58
order by
	htc.cook_id;

create view cook59_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 59
order by
	htc.cook_id;

create view cook60_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 60
order by
	htc.cook_id;

create view cook61_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 61
order by
	htc.cook_id;

create view cook62_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 62
order by
	htc.cook_id;

create view cook63_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 63
order by
	htc.cook_id;

create view cook64_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 64
order by
	htc.cook_id;

create view cook65_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 65
order by
	htc.cook_id;

create view cook66_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 66
order by
	htc.cook_id;

create view cook67_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 67
order by
	htc.cook_id;

create view cook68_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 68
order by
	htc.cook_id;

create view cook69_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 69
order by
	htc.cook_id;

create view cook70_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 70
order by
	htc.cook_id;

create view cook71_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 71
order by
	htc.cook_id;

create view cook72_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 72
order by
	htc.cook_id;

create view cook73_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 73
order by
	htc.cook_id;

create view cook74_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 74
order by
	htc.cook_id;

create view cook75_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 75
order by
	htc.cook_id;

create view cook76_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 76
order by
	htc.cook_id;

create view cook77_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 77
order by
	htc.cook_id;

create view cook78_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 78
order by
	htc.cook_id;

create view cook79_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 79
order by
	htc.cook_id;

create view cook80_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 80
order by
	htc.cook_id;

create view cook81_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 81
order by
	htc.cook_id;

create view cook82_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 82
order by
	htc.cook_id;

create view cook83_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 83
order by
	htc.cook_id;

create view cook84_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 84
order by
	htc.cook_id;

create view cook85_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 85
order by
	htc.cook_id;

create view cook86_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 86
order by
	htc.cook_id;

create view cook87_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 87
order by
	htc.cook_id;

create view cook88_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 88
order by
	htc.cook_id;

create view cook89_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 89
order by
	htc.cook_id;

create view cook90_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 90
order by
	htc.cook_id;

create view cook91_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 91
order by
	htc.cook_id;

create view cook92_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 92
order by
	htc.cook_id;

create view cook93_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 93
order by
	htc.cook_id;

create view cook94_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 94
order by
	htc.cook_id;

create view cook95_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 95
order by
	htc.cook_id;

create view cook96_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 96
order by
	htc.cook_id;

create view cook97_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 97
order by
	htc.cook_id;

create view cook98_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 98
order by
	htc.cook_id;

create view cook99_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 99
order by
	htc.cook_id;

create view cook100_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 100
order by
	htc.cook_id;

create view cook101_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 101
order by
	htc.cook_id;

create view cook102_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 102
order by
	htc.cook_id;

create view cook103_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 103
order by
	htc.cook_id;

create view cook104_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 104
order by
	htc.cook_id;

create view cook105_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 105
order by
	htc.cook_id;

create view cook106_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 106
order by
	htc.cook_id;

create view cook107_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 107
order by
	htc.cook_id;

create view cook108_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 108
order by
	htc.cook_id;

create view cook109_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 109
order by
	htc.cook_id;

create view cook110_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 110
order by
	htc.cook_id;

create view cook111_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 111
order by
	htc.cook_id;

create view cook112_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 112
order by
	htc.cook_id;

create view cook113_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 113
order by
	htc.cook_id;

create view cook114_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 114
order by
	htc.cook_id;

create view cook115_recipes as
select
	htc.cook_id,
	r.recipe_name,
	r.difficulty,
	r.description,
	r.pastry_or_not,
	r.nationality,
	r.prep_time,
	r.cooking_time,
	r.portions,
	r.recipe_pic
from
	has_to_cook htc
join
	recipes r on htc.recipe_name = r.recipe_name
where
	htc.cook_id = 115
order by
	htc.cook_id;

-- the following procedure is calculating the age of a cook based on his cook id
DELIMITER //

CREATE FUNCTION calculateCookAge(cook_id_param INT) RETURNS INT deterministic
BEGIN
    DECLARE cook_age_result INT;
    DECLARE birth_date_var DATE;

    -- Get the birth date of the cook
    SELECT birth_date INTO birth_date_var
    FROM cooks
    WHERE cook_id = cook_id_param;

    -- Calculate the age of the cook
    SET cook_age_result = TIMESTAMPDIFF(YEAR, birth_date_var, CURDATE());

    RETURN cook_age_result;
END//

DELIMITER ;
#------------------------------------#
-- Trigger to check consecutive participation of participants
delimiter //

create trigger check_consecutive_participation
before insert on participant
for each row
begin
    declare prev_participants int;
    
    -- Get the count of previous participations of the participant
    select count(*) into prev_participants
    from (
        select *
        from participant
        where cook_id = new.cook_id and (serial_number = new.serial_number-3 
			or serial_number = new.serial_number-2 or serial_number = new.serial_number-1) and contest_year = new.contest_year
        order by contest_year desc, serial_number desc
        limit 3
    ) as recent_participants;
    
    -- If the participant has participated in 3 consecutive episodes, prevent insertion
    if prev_participants = 3 then
        signal sqlstate '45000'
        set message_text = 'Participant has already participated in 3 consecutive episodes';
    end if;
end //

delimiter ;
#------------------------------------#
-- Trigger to check consecutive participation of judges
delimiter //

create trigger check_consecutive_judges
before insert on judge
for each row
begin
    declare prev_judges int;
    
    -- Get the count of previous participations of the judge
    select count(*) into prev_judges
    from (
        select *
        from judge
        where cook_id = new.cook_id and (serial_number = new.serial_number-3 
			or serial_number = new.serial_number-2 or serial_number = new.serial_number-1) and contest_year = new.contest_year
        order by contest_year desc, serial_number desc
        limit 3
    ) as recent_judges;
    
    -- If the judge has participated in 3 consecutive episodes, prevent insertion
    if prev_judges = 3 then
        signal sqlstate '45000'
        set message_text = 'Judge has already participated in 3 consecutive episodes';
    end if;
end //

delimiter ;

#------------------------------------#
create index idx_nationality on recipes (nationality);

#-----------------------------#
-- trigger for cehcking the consecutie taking part in three or more episodes
-- Trigger to check consecutive participation of judges and participants
#--------------------------#
-- create a proc for calculate  
delimiter //
create procedure calories_per_meal(
    in recipe_name_param varchar(50), 
    out calories_result numeric(7,2)
)
begin
    select sum(quantity * (fats * 9 + carbs * 4 + protein * 4)) into calories_result
    from contain
    join ingredients on contain.ing_name = ingredients.ing_name
    where contain.recipe_name = recipe_name_param;
end//
#--------------------------#
delimiter ;
#-----------------------------------------------------#
delimiter //
create function CalculateGrades (cook_id int, s_num int, contest_year numeric(4, 0)) returns int deterministic
begin
	declare total_grade int;
    
    select sum(grade) into total_grade
    from grades
    where grades.part_cook_id = cook_id and grades.serial_number = s_num and grades.contest_year = contest_year;
    
    return total_grade;
end//
delimiter ;
#-----------------------------------------------#
delimiter //

create procedure RandomlySelect (in t varchar(255), in num int)
begin
    set @sql = concat('select * from ', t, ' order by rand() limit ', num);
    prepare stmt from @sql;
    execute stmt;
    deallocate prepare stmt;
end//

delimiter ;
#--------------------------------------------------#
delimiter //

create procedure basic_kind(
    in recipe_name_param varchar(50),
    out basic_kind_result varchar(50)
)
begin
    declare basic_group varchar(30);
    select group_name into basic_group
        from basic_ingredient b join has_group g on b.ing_name = g.ing_name
        where b.recipe_name = recipe_name_param;
    case
		when basic_group = 'Coffee, Tea and more' then set basic_kind_result = 'Drink';
        when basic_group = 'Canned Foods' then set basic_kind_result = 'Preserved';
        when basic_group = 'Sweetening Agents' then set basic_kind_result = 'Dessert';
        when basic_group = 'Fats and Oils' then set basic_kind_result = 'Greasy';
        when basic_group = 'Eggs and Diary Products' then set basic_kind_result = 'Baked';
        when basic_group = 'Red Meat' then set basic_kind_result = 'Grilled';
        when basic_group = 'White Meat' then set basic_kind_result = 'Steamed';
        when basic_group = 'Fish' then set basic_kind_result = 'RAW';
        when basic_group = 'Sea Food' then set basic_kind_result = 'Fasting';
        when basic_group = 'Cereals and Potatoes' then set basic_kind_result = 'Vegan';
        when basic_group = 'Vegetables' then set basic_kind_result = 'Vegeterean';
        when basic_group = 'Alcoholic products' then set basic_kind_result = 'Alcoholic Drink';
        when basic_group = 'Fruits' then set basic_kind_result = 'Seasonal';
        when basic_group = 'Legumes' then set basic_kind_result = 'Boiled';
        when basic_group = 'Nuts' then set basic_kind_result = 'Crunchy';
        when basic_group = 'Misc' then set basic_kind_result = 'Marinated';
        -- tha mpoun kai alla meta
    end case;
end//

delimiter;

delimiter //
create trigger already_judge 
before insert on participant
for each row 
begin	
		declare appears int; #it will be 0 or 1 
        
        select count(*) into appears
			from judge j
			where j.cook_id = new.cook_id and j.serial_number = new.serial_number and j.contest_year = new.contest_year;
        
        if appears != 0 then
			signal sqlstate '45000'
			set message_text = 'This person is already a judge in this episode';
		end if;
end//
delimiter ;

#===================================================================#

delimiter //
create trigger already_participant 
before insert on judge
for each row 
begin	
	declare appears int;
	
    select count(*) into appears
        from participant p
		where p.cook_id = new.cook_id and p.serial_number = new.serial_number and p.contest_year = new.contest_year;
	
    if appears != 0 then
		signal sqlstate '45000'
        set message_text = 'This person is already a participant in this episode';
	end if;
end//

#------------------------------------------------#
delimiter ;
-- Trigger to check if a participant is assigned a recipe within their expertise for an episode
#-------------------------------------------#
delimiter //
create trigger check_expertise_before_cook_assignment
before insert on has_to_cook
for each row
begin
    declare cook_expertise varchar(30);
    declare recipe_nationality varchar(20);
    -- Get the cook's expertise
    select cuisine into cook_expertise
    from expertise
    where cook_id = new.cook_id;    
    
    -- Get the nationality of the recipe
    select nationality into recipe_nationality
    from recipes
    where recipe_name = new.recipe_name;
    
    -- Check if the cook's expertise matches the nationality of the recipe
    if recipe_nationality != cook_expertise then
        signal sqlstate '45000'
        set message_text = 'Participant is assigned a recipe outside of their expertise for the episode';
    end if;
end //
delimiter ;

DELIMITER //

CREATE PROCEDURE select_episode_winners(
    IN serial_number_param INT,
    IN contest_year_param NUMERIC(4, 0)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE winner_id INT;
    DECLARE winner_points INT;
    DECLARE winner_rank ENUM('a_cook', 'b_cook', 'c_cook', 'sous_chef', 'chef');
    DECLARE max_points INT;
   
    DECLARE cur CURSOR FOR
        SELECT part_cook_id, SUM(grade) AS total_points
        FROM grades
        WHERE serial_number = serial_number_param AND contest_year = contest_year_param
        GROUP BY part_cook_id;
   
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Step 1: Find the maximum points
    SELECT MAX(total_points) INTO max_points
    FROM (
        SELECT SUM(grade) AS total_points
        FROM grades
        WHERE serial_number = serial_number_param AND contest_year = contest_year_param
        GROUP BY part_cook_id
    ) AS points;

    -- Step 2: Open cursor to find winners
    OPEN cur;
   
    read_loop: LOOP
        FETCH cur INTO winner_id, winner_points;
        IF done THEN
            LEAVE read_loop;
        END IF;
       
        -- Only consider those with maximum points
        IF winner_points = max_points THEN
            -- Find the rank of the winner
            SELECT ranks INTO winner_rank
            FROM cooks
            WHERE cook_id = winner_id;
           
            -- Check if there are multiple winners with the same points and rank
            IF EXISTS (
                SELECT 1
                FROM cooks
                WHERE ranks = winner_rank AND cook_id IN (
                    SELECT part_cook_id
                    FROM grades
                    WHERE serial_number = serial_number_param AND contest_year = contest_year_param
                    GROUP BY part_cook_id
                    HAVING SUM(grade) = winner_points
                )
                GROUP BY ranks
                HAVING COUNT(*) > 1
            ) THEN
                -- Select a winner randomly among those with the highest rank
                SET winner_id = (
                    SELECT cook_id
                    FROM cooks
                    WHERE ranks = winner_rank AND cook_id IN (
                        SELECT part_cook_id
                        FROM grades
                        WHERE serial_number = serial_number_param AND contest_year = contest_year_param
                        GROUP BY part_cook_id
                        HAVING SUM(grade) = winner_points
                    )
                    ORDER BY RAND()
                    LIMIT 1
                );
            END IF;
           
            -- Output the winner for the episode
            SELECT winner_id AS winner, winner_points AS points, winner_rank AS win_rank;
            LEAVE read_loop;
        END IF;
    END LOOP;
   
    CLOSE cur;
END //

DELIMITER ;
