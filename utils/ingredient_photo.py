def parse_line(line):
    values = line.strip()[1:-1].split(', ')
    name, fats, carbs, protein, _ = values
    return (name.strip("'"), int(fats), int(carbs), int(protein))

i = 1
with open('ingredient.txt', 'r') as file:
    for line in file:
        print(line)
        name, fats, carbs, protein = parse_line(line)

        # Create user account
        ing_query = f"('{name}', {fats}, {carbs}, {protein}, 'ingredients/{i}.jpg'),\n"
        i+=1
        with open('ingredients_queries.txt', 'a') as file:
            file.write(ing_query)