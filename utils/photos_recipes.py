def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    print(len(values))
    rec_name, difficulty, desc, pastry, nation, prep, cook, portions, _ = values
    return (rec_name.strip("'"), int(difficulty), desc.strip("'"), int(pastry), nation.strip("'"), prep.strip("'"), cook.strip("'"), int(portions))

i = 1
with open('recipes.txt', 'r') as file:
    for line in file:
        print(line)
        rec_name, difficulty, desc, pastry, nation, prep, cook, portions = parse_line(line)

        rec_query = f"('{rec_name}', {difficulty}, '{desc}', {pastry}, '{nation}', '{prep}', '{cook}', {portions}, 'recipes/{i}.jpg'),\n"
        i+=1
        with open('cooks_new.txt', 'a') as file:
            file.write(rec_query)