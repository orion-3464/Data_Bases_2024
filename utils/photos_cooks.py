def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    user_id, first_name, last_name, birthdate, department_id, position, _ = values
    return (int(user_id), first_name.strip("'"), last_name.strip("'"), birthdate.strip("'"), int(department_id), position.strip("'"))

with open('cooks.txt', 'r') as file:
    for line in file:
        user_id, first_name, last_name, birthdate, dep_id, pos = parse_line(line)

        # Construct username
        username = first_name.lower() + '.' + last_name.lower()

        cook_query = f"({user_id}, '{first_name}', '{last_name}', '{birthdate}', {dep_id}, '{pos}', 'cooks/{user_id}.jpg'),\n"
        with open('cooks_new.txt', 'a') as file:
            file.write(cook_query)