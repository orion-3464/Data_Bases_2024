def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    user_id, first_name, last_name, birthdate, department_id, position, _ = values
    return (int(user_id), first_name.strip("'"), last_name.strip("'"))

with open('cooks.txt', 'r') as file:
    for line in file:
        user_id, first_name, last_name = parse_line(line)

        role = f"create role if not exists cook{user_id};\n"
        priv1 = f"grant update, insert, select on cook{user_id}_recipes to cook{user_id};\n"
        priv2 = f"grant insert, select on recipes to cook{user_id};\n"
        final = f"grant cook{user_id} to {first_name}_{last_name}@localhost;\n\n"

        with open('privs.txt', 'a') as file:
            file.write(role)
            file.write(priv1)
            file.write(priv2)
            file.write(final)