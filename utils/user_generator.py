def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    user_id, first_name, last_name, birthdate, department_id, position, _ = values
    return (int(user_id), first_name.strip("'"), last_name.strip("'"))

with open('cooks.txt', 'r') as file:
    for line in file:
        user_id, first_name, last_name = parse_line(line)

        # Construct username
        username = first_name.lower() + '.' + last_name.lower()

        # Create user account
        create_user_query = f"create user if not exists '{first_name}_{last_name}'@'localhost' identified by '{first_name}_{last_name}';\n"
        with open('users.txt', 'a') as file:
            file.write(create_user_query)

        create_user_query_d = f"drop user '{first_name}_{last_name}'@'localhost';\n"
        with open('users_d.txt', 'a') as file:
            file.write(create_user_query_d)