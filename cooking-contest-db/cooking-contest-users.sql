-- Creating a backup administrator
-- https://dev.mysql.com/doc/mysql-enterprise-backup/4.1/en/mysqlbackup.privileges.html

create user if not exists 'admin'@'localhost' identified by 'admin';
grant reload, super, process, insert, update, select, delete, show view, alter, create view on *.* to 'admin'@'localhost';
grant create, insert, drop, update on mysql.backup_progress to 'admin'@'localhost';
grant create, insert, select, drop, update, alter on mysql.backup_history 
    to 'admin'@'localhost';
grant replication client on *.* to 'admin'@'localhost';
grant create, insert, drop on mysql.backup_history_old to 'admin'@'localhost';
grant create, insert, drop, alter on mysql.backup_history_new to 'admin'@'localhost';
grant lock tables, select, create, drop, file on *.* to 'admin'@'localhost';
grant create, insert, drop, update on mysql.backup_sbt_history to 'admin'@'localhost';

-- mysqldump -u admin -p cooking_contest > backup.sql
-- mysql -u admin -p < backup.sql

-- Create cooks users

create user if not exists 'John_Doe'@'localhost' identified by 'John_Doe';
create user if not exists 'Jane_Smith'@'localhost' identified by 'Jane_Smith';
create user if not exists 'Robert_Brown'@'localhost' identified by 'Robert_Brown';
create user if not exists 'Emily_Davis'@'localhost' identified by 'Emily_Davis';
create user if not exists 'Michael_Wilson'@'localhost' identified by 'Michael_Wilson';
create user if not exists 'Sarah_Miller'@'localhost' identified by 'Sarah_Miller';
create user if not exists 'David_Martinez'@'localhost' identified by 'David_Martinez';
create user if not exists 'Laura_Garcia'@'localhost' identified by 'Laura_Garcia';
create user if not exists 'James_Rodriguez'@'localhost' identified by 'James_Rodriguez';
create user if not exists 'Olivia_Hernandez'@'localhost' identified by 'Olivia_Hernandez';
create user if not exists 'Daniel_Lopez'@'localhost' identified by 'Daniel_Lopez';
create user if not exists 'Sophia_Gonzalez'@'localhost' identified by 'Sophia_Gonzalez';
create user if not exists 'Matthew_Perez'@'localhost' identified by 'Matthew_Perez';
create user if not exists 'Emma_Martinez'@'localhost' identified by 'Emma_Martinez';
create user if not exists 'Joseph_Thomas'@'localhost' identified by 'Joseph_Thomas';
create user if not exists 'Ava_Moore'@'localhost' identified by 'Ava_Moore';
create user if not exists 'Charles_Taylor'@'localhost' identified by 'Charles_Taylor';
create user if not exists 'Mia_Anderson'@'localhost' identified by 'Mia_Anderson';
create user if not exists 'Christopher_Jackson'@'localhost' identified by 'Christopher_Jackson';
create user if not exists 'Isabella_White'@'localhost' identified by 'Isabella_White';
create user if not exists 'Anthony_Harris'@'localhost' identified by 'Anthony_Harris';
create user if not exists 'Grace_Clark'@'localhost' identified by 'Grace_Clark';
create user if not exists 'Andrew_Lewis'@'localhost' identified by 'Andrew_Lewis';
create user if not exists 'Chloe_Robinson'@'localhost' identified by 'Chloe_Robinson';
create user if not exists 'Benjamin_Walker'@'localhost' identified by 'Benjamin_Walker';
create user if not exists 'Amelia_Hall'@'localhost' identified by 'Amelia_Hall';
create user if not exists 'Nathan_Allen'@'localhost' identified by 'Nathan_Allen';
create user if not exists 'Hannah_Young'@'localhost' identified by 'Hannah_Young';
create user if not exists 'Ryan_King'@'localhost' identified by 'Ryan_King';
create user if not exists 'Lily_Wright'@'localhost' identified by 'Lily_Wright';
create user if not exists 'Joshua_Scott'@'localhost' identified by 'Joshua_Scott';
create user if not exists 'Zoe_Green'@'localhost' identified by 'Zoe_Green';
create user if not exists 'Jacob_Baker'@'localhost' identified by 'Jacob_Baker';
create user if not exists 'Ella_Adams'@'localhost' identified by 'Ella_Adams';
create user if not exists 'William_Nelson'@'localhost' identified by 'William_Nelson';
create user if not exists 'Madison_Carter'@'localhost' identified by 'Madison_Carter';
create user if not exists 'Ethan_Mitchell'@'localhost' identified by 'Ethan_Mitchell';
create user if not exists 'Victoria_Perez'@'localhost' identified by 'Victoria_Perez';
create user if not exists 'Mason_Roberts'@'localhost' identified by 'Mason_Roberts';
create user if not exists 'Scarlett_Turner'@'localhost' identified by 'Scarlett_Turner';
create user if not exists 'Alexander_Phillips'@'localhost' identified by 'Alexander_Phillips';
create user if not exists 'Abigail_Campbell'@'localhost' identified by 'Abigail_Campbell';
create user if not exists 'Logan_Parker'@'localhost' identified by 'Logan_Parker';
create user if not exists 'Lillian_Evans'@'localhost' identified by 'Lillian_Evans';
create user if not exists 'Lucas_Edwards'@'localhost' identified by 'Lucas_Edwards';
create user if not exists 'Sofia_Collins'@'localhost' identified by 'Sofia_Collins';
create user if not exists 'Jackson_Stewart'@'localhost' identified by 'Jackson_Stewart';
create user if not exists 'Charlotte_Sanchez'@'localhost' identified by 'Charlotte_Sanchez';
create user if not exists 'Henry_Morris'@'localhost' identified by 'Henry_Morris';
create user if not exists 'Aria_Rogers'@'localhost' identified by 'Aria_Rogers';
create user if not exists 'Gabriel_Reed'@'localhost' identified by 'Gabriel_Reed';
create user if not exists 'Samantha_Cook'@'localhost' identified by 'Samantha_Cook';
create user if not exists 'Matthew_Morgan'@'localhost' identified by 'Matthew_Morgan';
create user if not exists 'Penelope_Bell'@'localhost' identified by 'Penelope_Bell';
create user if not exists 'Aiden_Murphy'@'localhost' identified by 'Aiden_Murphy';
create user if not exists 'Aubrey_Bailey'@'localhost' identified by 'Aubrey_Bailey';
create user if not exists 'Caleb_Rivera'@'localhost' identified by 'Caleb_Rivera';
create user if not exists 'Evelyn_Cooper'@'localhost' identified by 'Evelyn_Cooper';
create user if not exists 'Hunter_Richardson'@'localhost' identified by 'Hunter_Richardson';
create user if not exists 'Ella_Cox'@'localhost' identified by 'Ella_Cox';
create user if not exists 'Isaac_Howard'@'localhost' identified by 'Isaac_Howard';
create user if not exists 'Scarlett_Ward'@'localhost' identified by 'Scarlett_Ward';
create user if not exists 'Liam_Torres'@'localhost' identified by 'Liam_Torres';
create user if not exists 'Layla_Peterson'@'localhost' identified by 'Layla_Peterson';
create user if not exists 'Lucas_Gray'@'localhost' identified by 'Lucas_Gray';
create user if not exists 'Emily_Ramirez'@'localhost' identified by 'Emily_Ramirez';
create user if not exists 'Owen_James'@'localhost' identified by 'Owen_James';
create user if not exists 'Grace_Watson'@'localhost' identified by 'Grace_Watson';
create user if not exists 'Samuel_Brooks'@'localhost' identified by 'Samuel_Brooks';
create user if not exists 'Chloe_Kelly'@'localhost' identified by 'Chloe_Kelly';
create user if not exists 'Wyatt_Sanders'@'localhost' identified by 'Wyatt_Sanders';
create user if not exists 'Avery_Price'@'localhost' identified by 'Avery_Price';
create user if not exists 'Jackson_Bennett'@'localhost' identified by 'Jackson_Bennett';
create user if not exists 'Harper_Wood'@'localhost' identified by 'Harper_Wood';
create user if not exists 'Carter_Barnes'@'localhost' identified by 'Carter_Barnes';
create user if not exists 'Zoey_Ross'@'localhost' identified by 'Zoey_Ross';
create user if not exists 'Julian_Henderson'@'localhost' identified by 'Julian_Henderson';
create user if not exists 'Aurora_Coleman'@'localhost' identified by 'Aurora_Coleman';
create user if not exists 'Levi_Jenkins'@'localhost' identified by 'Levi_Jenkins';
create user if not exists 'Victoria_Perry'@'localhost' identified by 'Victoria_Perry';
create user if not exists 'Sebastian_Powell'@'localhost' identified by 'Sebastian_Powell';
create user if not exists 'Hannah_Long'@'localhost' identified by 'Hannah_Long';
create user if not exists 'Eli_Patterson'@'localhost' identified by 'Eli_Patterson';
create user if not exists 'Riley_Hughes'@'localhost' identified by 'Riley_Hughes';
create user if not exists 'David_Flores'@'localhost' identified by 'David_Flores';
create user if not exists 'Zoey_Washington'@'localhost' identified by 'Zoey_Washington';
create user if not exists 'Anthony_Butler'@'localhost' identified by 'Anthony_Butler';
create user if not exists 'Ava_Simmons'@'localhost' identified by 'Ava_Simmons';
create user if not exists 'Henry_Foster'@'localhost' identified by 'Henry_Foster';
create user if not exists 'Sofia_Gonzalez'@'localhost' identified by 'Sofia_Gonzalez';
create user if not exists 'Christian_Bryant'@'localhost' identified by 'Christian_Bryant';
create user if not exists 'Riley_Alexander'@'localhost' identified by 'Riley_Alexander';
create user if not exists 'James_Russell'@'localhost' identified by 'James_Russell';
create user if not exists 'Evelyn_Griffin'@'localhost' identified by 'Evelyn_Griffin';
create user if not exists 'Daniel_Diaz'@'localhost' identified by 'Daniel_Diaz';
create user if not exists 'Liam_Hayes'@'localhost' identified by 'Liam_Hayes';
create user if not exists 'Scarlett_Myers'@'localhost' identified by 'Scarlett_Myers';
create user if not exists 'Noah_Ford'@'localhost' identified by 'Noah_Ford';
create user if not exists 'Avery_Hamilton'@'localhost' identified by 'Avery_Hamilton';
create user if not exists 'Olivia_Graham'@'localhost' identified by 'Olivia_Graham';
create user if not exists 'Boska_Dinuv'@'localhost' identified by 'Boska_Dinuv';
create user if not exists 'Marouska_Galei'@'localhost' identified by 'Marouska_Galei';
create user if not exists 'Bobi_Bush'@'localhost' identified by 'Bobi_Bush';
create user if not exists 'Johnakis_Johnakos'@'localhost' identified by 'Johnakis_Johnakos';
create user if not exists 'Takaros_Tselai'@'localhost' identified by 'Takaros_Tselai';
create user if not exists 'Abo_Kono'@'localhost' identified by 'Abo_Kono';
create user if not exists 'Anakin_Skywalker'@'localhost' identified by 'Anakin_Skywalker';
create user if not exists 'Leia_Skywalker'@'localhost' identified by 'Leia_Skywalker';
create user if not exists 'Luck_Skywalker'@'localhost' identified by 'Luck_Skywalker';
create user if not exists 'Rei_NotSkywalker'@'localhost' identified by 'Rei_NotSkywalker';
create user if not exists 'Darth_Vader'@'localhost' identified by 'Darth_Vader';
create user if not exists 'Palpatine_Dewit'@'localhost' identified by 'Palpatine_Dewit';
create user if not exists 'Bond_Jamesbond'@'localhost' identified by 'Bond_Jamesbond';
create user if not exists 'Oliver_Twist'@'localhost' identified by 'Oliver_Twist';
create user if not exists 'Donatello_Green'@'localhost' identified by 'Donatello_Green';

/*
drop user 'John_Doe'@'localhost';
drop user 'Jane_Smith'@'localhost';
drop user 'Robert_Brown'@'localhost';
drop user 'Emily_Davis'@'localhost';
drop user 'Michael_Wilson'@'localhost';
drop user 'Sarah_Miller'@'localhost';
drop user 'David_Martinez'@'localhost';
drop user 'Laura_Garcia'@'localhost';
drop user 'James_Rodriguez'@'localhost';
drop user 'Olivia_Hernandez'@'localhost';
drop user 'Daniel_Lopez'@'localhost';
drop user 'Sophia_Gonzalez'@'localhost';
drop user 'Matthew_Perez'@'localhost';
drop user 'Emma_Martinez'@'localhost';
drop user 'Joseph_Thomas'@'localhost';
drop user 'Ava_Moore'@'localhost';
drop user 'Charles_Taylor'@'localhost';
drop user 'Mia_Anderson'@'localhost';
drop user 'Christopher_Jackson'@'localhost';
drop user 'Isabella_White'@'localhost';
drop user 'Anthony_Harris'@'localhost';
drop user 'Grace_Clark'@'localhost';
drop user 'Andrew_Lewis'@'localhost';
drop user 'Chloe_Robinson'@'localhost';
drop user 'Benjamin_Walker'@'localhost';
drop user 'Amelia_Hall'@'localhost';
drop user 'Nathan_Allen'@'localhost';
drop user 'Hannah_Young'@'localhost';
drop user 'Ryan_King'@'localhost';
drop user 'Lily_Wright'@'localhost';
drop user 'Joshua_Scott'@'localhost';
drop user 'Zoe_Green'@'localhost';
drop user 'Jacob_Baker'@'localhost';
drop user 'Ella_Adams'@'localhost';
drop user 'William_Nelson'@'localhost';
drop user 'Madison_Carter'@'localhost';
drop user 'Ethan_Mitchell'@'localhost';
drop user 'Victoria_Perez'@'localhost';
drop user 'Mason_Roberts'@'localhost';
drop user 'Scarlett_Turner'@'localhost';
drop user 'Alexander_Phillips'@'localhost';
drop user 'Abigail_Campbell'@'localhost';
drop user 'Logan_Parker'@'localhost';
drop user 'Lillian_Evans'@'localhost';
drop user 'Lucas_Edwards'@'localhost';
drop user 'Sofia_Collins'@'localhost';
drop user 'Jackson_Stewart'@'localhost';
drop user 'Charlotte_Sanchez'@'localhost';
drop user 'Henry_Morris'@'localhost';
drop user 'Aria_Rogers'@'localhost';
drop user 'Gabriel_Reed'@'localhost';
drop user 'Samantha_Cook'@'localhost';
drop user 'Matthew_Morgan'@'localhost';
drop user 'Penelope_Bell'@'localhost';
drop user 'Aiden_Murphy'@'localhost';
drop user 'Aubrey_Bailey'@'localhost';
drop user 'Caleb_Rivera'@'localhost';
drop user 'Evelyn_Cooper'@'localhost';
drop user 'Hunter_Richardson'@'localhost';
drop user 'Ella_Cox'@'localhost';
drop user 'Isaac_Howard'@'localhost';
drop user 'Scarlett_Ward'@'localhost';
drop user 'Liam_Torres'@'localhost';
drop user 'Layla_Peterson'@'localhost';
drop user 'Lucas_Gray'@'localhost';
drop user 'Emily_Ramirez'@'localhost';
drop user 'Owen_James'@'localhost';
drop user 'Grace_Watson'@'localhost';
drop user 'Samuel_Brooks'@'localhost';
drop user 'Chloe_Kelly'@'localhost';
drop user 'Wyatt_Sanders'@'localhost';
drop user 'Avery_Price'@'localhost';
drop user 'Jackson_Bennett'@'localhost';
drop user 'Harper_Wood'@'localhost';
drop user 'Carter_Barnes'@'localhost';
drop user 'Zoey_Ross'@'localhost';
drop user 'Julian_Henderson'@'localhost';
drop user 'Aurora_Coleman'@'localhost';
drop user 'Levi_Jenkins'@'localhost';
drop user 'Victoria_Perry'@'localhost';
drop user 'Sebastian_Powell'@'localhost';
drop user 'Hannah_Long'@'localhost';
drop user 'Eli_Patterson'@'localhost';
drop user 'Riley_Hughes'@'localhost';
drop user 'David_Flores'@'localhost';
drop user 'Zoey_Washington'@'localhost';
drop user 'Anthony_Butler'@'localhost';
drop user 'Ava_Simmons'@'localhost';
drop user 'Henry_Foster'@'localhost';
drop user 'Sofia_Gonzalez'@'localhost';
drop user 'Christian_Bryant'@'localhost';
drop user 'Riley_Alexander'@'localhost';
drop user 'James_Russell'@'localhost';
drop user 'Evelyn_Griffin'@'localhost';
drop user 'Daniel_Diaz'@'localhost';
drop user 'Liam_Hayes'@'localhost';
drop user 'Scarlett_Myers'@'localhost';
drop user 'Noah_Ford'@'localhost';
drop user 'Avery_Hamilton'@'localhost';
drop user 'Olivia_Graham'@'localhost';
drop user 'Boska_Dinuv'@'localhost';
drop user 'Marouska_Galei'@'localhost';
drop user 'Bobi_Bush'@'localhost';
drop user 'Johnakis_Johnakos'@'localhost';
drop user 'Takaros_Tselai'@'localhost';
drop user 'Abo_Kono'@'localhost';
drop user 'Anakin_Skywalker'@'localhost';
drop user 'Leia_Skywalker'@'localhost';
drop user 'Luck_Skywalker'@'localhost';
drop user 'Rei_NotSkywalker'@'localhost';
drop user 'Darth_Vader'@'localhost';
drop user 'Palpatine_Dewit'@'localhost';
drop user 'Bond_Jamesbond'@'localhost';
drop user 'Oliver_Twist'@'localhost';
drop user 'Donatello_Green'@'localhost';
*/

-- Privileges

create role if not exists cook1;
grant update, insert, select on cook1_recipes to cook1;
grant insert, select on recipes to cook1;
grant cook1 to John_Doe@localhost;

create role if not exists cook2;
grant update, insert, select on cook2_recipes to cook2;
grant insert, select on recipes to cook2;
grant cook2 to Jane_Smith@localhost;

create role if not exists cook3;
grant update, insert, select on cook3_recipes to cook3;
grant insert, select on recipes to cook3;
grant cook3 to Robert_Brown@localhost;

create role if not exists cook4;
grant update, insert, select on cook4_recipes to cook4;
grant insert, select on recipes to cook4;
grant cook4 to Emily_Davis@localhost;

create role if not exists cook5;
grant update, insert, select on cook5_recipes to cook5;
grant insert, select on recipes to cook5;
grant cook5 to Michael_Wilson@localhost;

create role if not exists cook6;
grant update, insert, select on cook6_recipes to cook6;
grant insert, select on recipes to cook6;
grant cook6 to Sarah_Miller@localhost;

create role if not exists cook7;
grant update, insert, select on cook7_recipes to cook7;
grant insert, select on recipes to cook7;
grant cook7 to David_Martinez@localhost;

create role if not exists cook8;
grant update, insert, select on cook8_recipes to cook8;
grant insert, select on recipes to cook8;
grant cook8 to Laura_Garcia@localhost;

create role if not exists cook9;
grant update, insert, select on cook9_recipes to cook9;
grant insert, select on recipes to cook9;
grant cook9 to James_Rodriguez@localhost;

create role if not exists cook10;
grant update, insert, select on cook10_recipes to cook10;
grant insert, select on recipes to cook10;
grant cook10 to Olivia_Hernandez@localhost;

create role if not exists cook11;
grant update, insert, select on cook11_recipes to cook11;
grant insert, select on recipes to cook11;
grant cook11 to Daniel_Lopez@localhost;

create role if not exists cook12;
grant update, insert, select on cook12_recipes to cook12;
grant insert, select on recipes to cook12;
grant cook12 to Sophia_Gonzalez@localhost;

create role if not exists cook13;
grant update, insert, select on cook13_recipes to cook13;
grant insert, select on recipes to cook13;
grant cook13 to Matthew_Perez@localhost;

create role if not exists cook14;
grant update, insert, select on cook14_recipes to cook14;
grant insert, select on recipes to cook14;
grant cook14 to Emma_Martinez@localhost;

create role if not exists cook15;
grant update, insert, select on cook15_recipes to cook15;
grant insert, select on recipes to cook15;
grant cook15 to Joseph_Thomas@localhost;

create role if not exists cook16;
grant update, insert, select on cook16_recipes to cook16;
grant insert, select on recipes to cook16;
grant cook16 to Ava_Moore@localhost;

create role if not exists cook17;
grant update, insert, select on cook17_recipes to cook17;
grant insert, select on recipes to cook17;
grant cook17 to Charles_Taylor@localhost;

create role if not exists cook18;
grant update, insert, select on cook18_recipes to cook18;
grant insert, select on recipes to cook18;
grant cook18 to Mia_Anderson@localhost;

create role if not exists cook19;
grant update, insert, select on cook19_recipes to cook19;
grant insert, select on recipes to cook19;
grant cook19 to Christopher_Jackson@localhost;

create role if not exists cook20;
grant update, insert, select on cook20_recipes to cook20;
grant insert, select on recipes to cook20;
grant cook20 to Isabella_White@localhost;

create role if not exists cook21;
grant update, insert, select on cook21_recipes to cook21;
grant insert, select on recipes to cook21;
grant cook21 to Anthony_Harris@localhost;

create role if not exists cook22;
grant update, insert, select on cook22_recipes to cook22;
grant insert, select on recipes to cook22;
grant cook22 to Grace_Clark@localhost;

create role if not exists cook23;
grant update, insert, select on cook23_recipes to cook23;
grant insert, select on recipes to cook23;
grant cook23 to Andrew_Lewis@localhost;

create role if not exists cook24;
grant update, insert, select on cook24_recipes to cook24;
grant insert, select on recipes to cook24;
grant cook24 to Chloe_Robinson@localhost;

create role if not exists cook25;
grant update, insert, select on cook25_recipes to cook25;
grant insert, select on recipes to cook25;
grant cook25 to Benjamin_Walker@localhost;

create role if not exists cook26;
grant update, insert, select on cook26_recipes to cook26;
grant insert, select on recipes to cook26;
grant cook26 to Amelia_Hall@localhost;

create role if not exists cook27;
grant update, insert, select on cook27_recipes to cook27;
grant insert, select on recipes to cook27;
grant cook27 to Nathan_Allen@localhost;

create role if not exists cook28;
grant update, insert, select on cook28_recipes to cook28;
grant insert, select on recipes to cook28;
grant cook28 to Hannah_Young@localhost;

create role if not exists cook29;
grant update, insert, select on cook29_recipes to cook29;
grant insert, select on recipes to cook29;
grant cook29 to Ryan_King@localhost;

create role if not exists cook30;
grant update, insert, select on cook30_recipes to cook30;
grant insert, select on recipes to cook30;
grant cook30 to Lily_Wright@localhost;

create role if not exists cook31;
grant update, insert, select on cook31_recipes to cook31;
grant insert, select on recipes to cook31;
grant cook31 to Joshua_Scott@localhost;

create role if not exists cook32;
grant update, insert, select on cook32_recipes to cook32;
grant insert, select on recipes to cook32;
grant cook32 to Zoe_Green@localhost;

create role if not exists cook33;
grant update, insert, select on cook33_recipes to cook33;
grant insert, select on recipes to cook33;
grant cook33 to Jacob_Baker@localhost;

create role if not exists cook34;
grant update, insert, select on cook34_recipes to cook34;
grant insert, select on recipes to cook34;
grant cook34 to Ella_Adams@localhost;

create role if not exists cook35;
grant update, insert, select on cook35_recipes to cook35;
grant insert, select on recipes to cook35;
grant cook35 to William_Nelson@localhost;

create role if not exists cook36;
grant update, insert, select on cook36_recipes to cook36;
grant insert, select on recipes to cook36;
grant cook36 to Madison_Carter@localhost;

create role if not exists cook37;
grant update, insert, select on cook37_recipes to cook37;
grant insert, select on recipes to cook37;
grant cook37 to Ethan_Mitchell@localhost;

create role if not exists cook38;
grant update, insert, select on cook38_recipes to cook38;
grant insert, select on recipes to cook38;
grant cook38 to Victoria_Perez@localhost;

create role if not exists cook39;
grant update, insert, select on cook39_recipes to cook39;
grant insert, select on recipes to cook39;
grant cook39 to Mason_Roberts@localhost;

create role if not exists cook40;
grant update, insert, select on cook40_recipes to cook40;
grant insert, select on recipes to cook40;
grant cook40 to Scarlett_Turner@localhost;

create role if not exists cook41;
grant update, insert, select on cook41_recipes to cook41;
grant insert, select on recipes to cook41;
grant cook41 to Alexander_Phillips@localhost;

create role if not exists cook42;
grant update, insert, select on cook42_recipes to cook42;
grant insert, select on recipes to cook42;
grant cook42 to Abigail_Campbell@localhost;

create role if not exists cook43;
grant update, insert, select on cook43_recipes to cook43;
grant insert, select on recipes to cook43;
grant cook43 to Logan_Parker@localhost;

create role if not exists cook44;
grant update, insert, select on cook44_recipes to cook44;
grant insert, select on recipes to cook44;
grant cook44 to Lillian_Evans@localhost;

create role if not exists cook45;
grant update, insert, select on cook45_recipes to cook45;
grant insert, select on recipes to cook45;
grant cook45 to Lucas_Edwards@localhost;

create role if not exists cook46;
grant update, insert, select on cook46_recipes to cook46;
grant insert, select on recipes to cook46;
grant cook46 to Sofia_Collins@localhost;

create role if not exists cook47;
grant update, insert, select on cook47_recipes to cook47;
grant insert, select on recipes to cook47;
grant cook47 to Jackson_Stewart@localhost;

create role if not exists cook48;
grant update, insert, select on cook48_recipes to cook48;
grant insert, select on recipes to cook48;
grant cook48 to Charlotte_Sanchez@localhost;

create role if not exists cook49;
grant update, insert, select on cook49_recipes to cook49;
grant insert, select on recipes to cook49;
grant cook49 to Henry_Morris@localhost;

create role if not exists cook50;
grant update, insert, select on cook50_recipes to cook50;
grant insert, select on recipes to cook50;
grant cook50 to Aria_Rogers@localhost;

create role if not exists cook51;
grant update, insert, select on cook51_recipes to cook51;
grant insert, select on recipes to cook51;
grant cook51 to Gabriel_Reed@localhost;

create role if not exists cook52;
grant update, insert, select on cook52_recipes to cook52;
grant insert, select on recipes to cook52;
grant cook52 to Samantha_Cook@localhost;

create role if not exists cook53;
grant update, insert, select on cook53_recipes to cook53;
grant insert, select on recipes to cook53;
grant cook53 to Matthew_Morgan@localhost;

create role if not exists cook54;
grant update, insert, select on cook54_recipes to cook54;
grant insert, select on recipes to cook54;
grant cook54 to Penelope_Bell@localhost;

create role if not exists cook55;
grant update, insert, select on cook55_recipes to cook55;
grant insert, select on recipes to cook55;
grant cook55 to Aiden_Murphy@localhost;

create role if not exists cook56;
grant update, insert, select on cook56_recipes to cook56;
grant insert, select on recipes to cook56;
grant cook56 to Aubrey_Bailey@localhost;

create role if not exists cook57;
grant update, insert, select on cook57_recipes to cook57;
grant insert, select on recipes to cook57;
grant cook57 to Caleb_Rivera@localhost;

create role if not exists cook58;
grant update, insert, select on cook58_recipes to cook58;
grant insert, select on recipes to cook58;
grant cook58 to Evelyn_Cooper@localhost;

create role if not exists cook59;
grant update, insert, select on cook59_recipes to cook59;
grant insert, select on recipes to cook59;
grant cook59 to Hunter_Richardson@localhost;

create role if not exists cook60;
grant update, insert, select on cook60_recipes to cook60;
grant insert, select on recipes to cook60;
grant cook60 to Ella_Cox@localhost;

create role if not exists cook61;
grant update, insert, select on cook61_recipes to cook61;
grant insert, select on recipes to cook61;
grant cook61 to Isaac_Howard@localhost;

create role if not exists cook62;
grant update, insert, select on cook62_recipes to cook62;
grant insert, select on recipes to cook62;
grant cook62 to Scarlett_Ward@localhost;

create role if not exists cook63;
grant update, insert, select on cook63_recipes to cook63;
grant insert, select on recipes to cook63;
grant cook63 to Liam_Torres@localhost;

create role if not exists cook64;
grant update, insert, select on cook64_recipes to cook64;
grant insert, select on recipes to cook64;
grant cook64 to Layla_Peterson@localhost;

create role if not exists cook65;
grant update, insert, select on cook65_recipes to cook65;
grant insert, select on recipes to cook65;
grant cook65 to Lucas_Gray@localhost;

create role if not exists cook66;
grant update, insert, select on cook66_recipes to cook66;
grant insert, select on recipes to cook66;
grant cook66 to Emily_Ramirez@localhost;

create role if not exists cook67;
grant update, insert, select on cook67_recipes to cook67;
grant insert, select on recipes to cook67;
grant cook67 to Owen_James@localhost;

create role if not exists cook68;
grant update, insert, select on cook68_recipes to cook68;
grant insert, select on recipes to cook68;
grant cook68 to Grace_Watson@localhost;

create role if not exists cook69;
grant update, insert, select on cook69_recipes to cook69;
grant insert, select on recipes to cook69;
grant cook69 to Samuel_Brooks@localhost;

create role if not exists cook70;
grant update, insert, select on cook70_recipes to cook70;
grant insert, select on recipes to cook70;
grant cook70 to Chloe_Kelly@localhost;

create role if not exists cook71;
grant update, insert, select on cook71_recipes to cook71;
grant insert, select on recipes to cook71;
grant cook71 to Wyatt_Sanders@localhost;

create role if not exists cook72;
grant update, insert, select on cook72_recipes to cook72;
grant insert, select on recipes to cook72;
grant cook72 to Avery_Price@localhost;

create role if not exists cook73;
grant update, insert, select on cook73_recipes to cook73;
grant insert, select on recipes to cook73;
grant cook73 to Jackson_Bennett@localhost;

create role if not exists cook74;
grant update, insert, select on cook74_recipes to cook74;
grant insert, select on recipes to cook74;
grant cook74 to Harper_Wood@localhost;

create role if not exists cook75;
grant update, insert, select on cook75_recipes to cook75;
grant insert, select on recipes to cook75;
grant cook75 to Carter_Barnes@localhost;

create role if not exists cook76;
grant update, insert, select on cook76_recipes to cook76;
grant insert, select on recipes to cook76;
grant cook76 to Zoey_Ross@localhost;

create role if not exists cook77;
grant update, insert, select on cook77_recipes to cook77;
grant insert, select on recipes to cook77;
grant cook77 to Julian_Henderson@localhost;

create role if not exists cook78;
grant update, insert, select on cook78_recipes to cook78;
grant insert, select on recipes to cook78;
grant cook78 to Aurora_Coleman@localhost;

create role if not exists cook79;
grant update, insert, select on cook79_recipes to cook79;
grant insert, select on recipes to cook79;
grant cook79 to Levi_Jenkins@localhost;

create role if not exists cook80;
grant update, insert, select on cook80_recipes to cook80;
grant insert, select on recipes to cook80;
grant cook80 to Victoria_Perry@localhost;

create role if not exists cook81;
grant update, insert, select on cook81_recipes to cook81;
grant insert, select on recipes to cook81;
grant cook81 to Sebastian_Powell@localhost;

create role if not exists cook82;
grant update, insert, select on cook82_recipes to cook82;
grant insert, select on recipes to cook82;
grant cook82 to Hannah_Long@localhost;

create role if not exists cook83;
grant update, insert, select on cook83_recipes to cook83;
grant insert, select on recipes to cook83;
grant cook83 to Eli_Patterson@localhost;

create role if not exists cook84;
grant update, insert, select on cook84_recipes to cook84;
grant insert, select on recipes to cook84;
grant cook84 to Riley_Hughes@localhost;

create role if not exists cook85;
grant update, insert, select on cook85_recipes to cook85;
grant insert, select on recipes to cook85;
grant cook85 to David_Flores@localhost;

create role if not exists cook86;
grant update, insert, select on cook86_recipes to cook86;
grant insert, select on recipes to cook86;
grant cook86 to Zoey_Washington@localhost;

create role if not exists cook87;
grant update, insert, select on cook87_recipes to cook87;
grant insert, select on recipes to cook87;
grant cook87 to Anthony_Butler@localhost;

create role if not exists cook88;
grant update, insert, select on cook88_recipes to cook88;
grant insert, select on recipes to cook88;
grant cook88 to Ava_Simmons@localhost;

create role if not exists cook89;
grant update, insert, select on cook89_recipes to cook89;
grant insert, select on recipes to cook89;
grant cook89 to Henry_Foster@localhost;

create role if not exists cook90;
grant update, insert, select on cook90_recipes to cook90;
grant insert, select on recipes to cook90;
grant cook90 to Sofia_Gonzalez@localhost;

create role if not exists cook91;
grant update, insert, select on cook91_recipes to cook91;
grant insert, select on recipes to cook91;
grant cook91 to Christian_Bryant@localhost;

create role if not exists cook92;
grant update, insert, select on cook92_recipes to cook92;
grant insert, select on recipes to cook92;
grant cook92 to Riley_Alexander@localhost;

create role if not exists cook93;
grant update, insert, select on cook93_recipes to cook93;
grant insert, select on recipes to cook93;
grant cook93 to James_Russell@localhost;

create role if not exists cook94;
grant update, insert, select on cook94_recipes to cook94;
grant insert, select on recipes to cook94;
grant cook94 to Evelyn_Griffin@localhost;

create role if not exists cook95;
grant update, insert, select on cook95_recipes to cook95;
grant insert, select on recipes to cook95;
grant cook95 to Daniel_Diaz@localhost;

create role if not exists cook96;
grant update, insert, select on cook96_recipes to cook96;
grant insert, select on recipes to cook96;
grant cook96 to Liam_Hayes@localhost;

create role if not exists cook97;
grant update, insert, select on cook97_recipes to cook97;
grant insert, select on recipes to cook97;
grant cook97 to Scarlett_Myers@localhost;

create role if not exists cook98;
grant update, insert, select on cook98_recipes to cook98;
grant insert, select on recipes to cook98;
grant cook98 to Noah_Ford@localhost;

create role if not exists cook99;
grant update, insert, select on cook99_recipes to cook99;
grant insert, select on recipes to cook99;
grant cook99 to Avery_Hamilton@localhost;

create role if not exists cook100;
grant update, insert, select on cook100_recipes to cook100;
grant insert, select on recipes to cook100;
grant cook100 to Olivia_Graham@localhost;

create role if not exists cook101;
grant update, insert, select on cook101_recipes to cook101;
grant insert, select on recipes to cook101;
grant cook101 to Boska_Dinuv@localhost;

create role if not exists cook102;
grant update, insert, select on cook102_recipes to cook102;
grant insert, select on recipes to cook102;
grant cook102 to Marouska_Galei@localhost;

create role if not exists cook103;
grant update, insert, select on cook103_recipes to cook103;
grant insert, select on recipes to cook103;
grant cook103 to Bobi_Bush@localhost;

create role if not exists cook104;
grant update, insert, select on cook104_recipes to cook104;
grant insert, select on recipes to cook104;
grant cook104 to Johnakis_Johnakos@localhost;

create role if not exists cook105;
grant update, insert, select on cook105_recipes to cook105;
grant insert, select on recipes to cook105;
grant cook105 to Takaros_Tselai@localhost;

create role if not exists cook106;
grant update, insert, select on cook106_recipes to cook106;
grant insert, select on recipes to cook106;
grant cook106 to Abo_Kono@localhost;

create role if not exists cook107;
grant update, insert, select on cook107_recipes to cook107;
grant insert, select on recipes to cook107;
grant cook107 to Anakin_Skywalker@localhost;

create role if not exists cook108;
grant update, insert, select on cook108_recipes to cook108;
grant insert, select on recipes to cook108;
grant cook108 to Leia_Skywalker@localhost;

create role if not exists cook109;
grant update, insert, select on cook109_recipes to cook109;
grant insert, select on recipes to cook109;
grant cook109 to Luck_Skywalker@localhost;

create role if not exists cook110;
grant update, insert, select on cook110_recipes to cook110;
grant insert, select on recipes to cook110;
grant cook110 to Rei_NotSkywalker@localhost;

create role if not exists cook111;
grant update, insert, select on cook111_recipes to cook111;
grant insert, select on recipes to cook111;
grant cook111 to Darth_Vader@localhost;

create role if not exists cook112;
grant update, insert, select on cook112_recipes to cook112;
grant insert, select on recipes to cook112;
grant cook112 to Palpatine_Dewit@localhost;

create role if not exists cook113;
grant update, insert, select on cook113_recipes to cook113;
grant insert, select on recipes to cook113;
grant cook113 to Bond_Jamesbond@localhost;

create role if not exists cook114;
grant update, insert, select on cook114_recipes to cook114;
grant insert, select on recipes to cook114;
grant cook114 to Oliver_Twist@localhost;

create role if not exists cook115;
grant update, insert, select on cook115_recipes to cook115;
grant insert, select on recipes to cook115;
grant cook115 to Donatello_Green@localhost;

-- Anybode can revoke privileges with revoke