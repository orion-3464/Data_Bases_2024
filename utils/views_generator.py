for i in range(1, 116):
    create_view_query = f"create view cook{i}_recipes as\nselect\n\thtc.cook_id,\n\tr.recipe_name,\n\tr.difficulty,\n\tr.description,\n\tr.pastry_or_not,\n\tr.nationality,\n\tr.prep_time,\n\tr.cooking_time,\n\tr.portions,\n\tr.recipe_pic\nfrom\n\thas_to_cook htc\njoin\n\trecipes r on htc.recipe_name = r.recipe_name\nwhere\n\thtc.cook_id = {i}\norder by\n\thtc.cook_id;\n\n"
    with open('views.txt', 'a') as file:
        file.write(create_view_query)