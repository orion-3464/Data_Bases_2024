def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    name, desc, _ = values
    return (name.strip("'"), desc.strip("'"))

i = 1
with open('gear.txt', 'r') as file:
    for line in file:
        name, desc = parse_line(line)

        # Create user account
        ing_query = f"('{name}', '{desc}', 'gears/{i}.jpg'),\n"
        i+=1
        with open('gear_queries.txt', 'a') as file:
            file.write(ing_query)