
-- Query 3.1
select part_cook_id as Participant_ID, avg(grade) as average_grade
from grades
group by part_cook_id;

select r.nationality as National_Cuisine, avg(g.grade) as average_grade
from
grades g
join 
    participant p on g.part_cook_id = p.cook_id and g.serial_number = p.serial_number and g.contest_year = p.contest_year
join 
    has_to_cook h on p.cook_id = h.cook_id and p.serial_number = h.serial_number and p.contest_year = h.contest_year
join 
    recipes r on h.recipe_name = r.recipe_name
group by
    r.nationality;
    
-- 3.2
#-------
with cooks_by_nationality as (
    select r.nationality, p.cook_id
    from has_to_cook h
    join recipes r on h.recipe_name = r.recipe_name
    join participant p on h.cook_id = p.cook_id
    group by r.nationality, p.cook_id
),
cooks_by_contest_year as (
    select p.contest_year, p.cook_id
    from participant p
    group by p.contest_year, p.cook_id
)
select n.nationality, c.contest_year, n.cook_id
from cooks_by_nationality n
inner join cooks_by_contest_year c on n.cook_id = c.cook_id;

-- 3.3
SELECT p.cook_id, COUNT(*) AS recipe_count
FROM participant p
JOIN has_to_cook h ON p.cook_id = h.cook_id
JOIN recipes r ON h.recipe_name = r.recipe_name
WHERE calculateCookAge(p.cook_id) < 30
GROUP BY p.cook_id
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 3.4
SELECT c.cook_id, c.first_name, c.last_name
FROM cooks c
LEFT JOIN judge j ON c.cook_id = j.cook_id
WHERE j.cook_id IS NULL;

-- 3.5
#-----
#================= QUERY 5 ==================#
WITH temp AS (
    SELECT 
        judge_appearances.cook_id, 
        judge_appearances.contest_year, 
        num_appearances AS appearances
    FROM (
        SELECT 
            cook_id, 
            contest_year, 
            COUNT(*) AS num_appearances
        FROM judge
        GROUP BY cook_id, contest_year
    ) AS judge_appearances
    WHERE judge_appearances.num_appearances > 3
)

SELECT 
    cook_id, 
    contest_year, 
    appearances
FROM 
    temp
WHERE 
    appearances IN (
        SELECT 
            appearances
        FROM 
            temp
        GROUP BY 
            appearances
        HAVING 
            COUNT(*) > 1
);

-- 3.6
explain 
WITH RecipeTags AS (
    SELECT 
        rt1.tag AS tag1,
        rt2.tag AS tag2,
        COUNT(*) AS episode_count
    FROM 
        meal_tag rt1
    JOIN 
        meal_tag rt2 ON rt1.recipe_name = rt2.recipe_name AND rt1.tag < rt2.tag
    JOIN 
        has_to_cook hc ON rt1.recipe_name = hc.recipe_name
    JOIN 
        episode e ON hc.serial_number = e.serial_number AND hc.contest_year = e.contest_year
    GROUP BY 
        rt1.tag, rt2.tag
)
SELECT 
    tag1,
    tag2,
    episode_count
FROM 
    RecipeTags
ORDER BY 
    episode_count DESC
LIMIT 3;

-- Force Index
CREATE INDEX idx_meal_tag_recipe_name_tag ON meal_tag(recipe_name, tag);
CREATE INDEX idx_has_to_cook_recipe_serial_contest ON has_to_cook(recipe_name, serial_number, contest_year);
CREATE INDEX idx_episode_serial_contest ON episode(serial_number, contest_year);
explain
WITH RecipeTags AS (
    SELECT 
        rt1.tag AS tag1,
        rt2.tag AS tag2,
        COUNT(*) AS episode_count
    FROM 
        meal_tag rt1 FORCE INDEX (idx_meal_tag_recipe_name_tag)
    JOIN 
        meal_tag rt2 FORCE INDEX (idx_meal_tag_recipe_name_tag)
        ON rt1.recipe_name = rt2.recipe_name AND rt1.tag < rt2.tag
    JOIN 
        has_to_cook hc FORCE INDEX (idx_has_to_cook_recipe_serial_contest)
        ON rt1.recipe_name = hc.recipe_name
    JOIN 
        episode e FORCE INDEX (idx_episode_serial_contest)
        ON hc.serial_number = e.serial_number AND hc.contest_year = e.contest_year
    GROUP BY 
        rt1.tag, rt2.tag
)
SELECT 
    tag1,
    tag2,
    episode_count
FROM 
    RecipeTags
ORDER BY 
    episode_count DESC
LIMIT 3;

-- 3.7
with cook_appearances as (
    select cook_id, count(*) as appearances
    from participant
    group by cook_id
),
max_appearances as (
    select max(appearances) as max_appearances
    from cook_appearances
)
select c.cook_id, c.first_name, c.last_name, ca.appearances
from cooks c
join cook_appearances ca on c.cook_id = ca.cook_id
join max_appearances ma on ca.appearances <= ma.max_appearances - 5
order by ca.appearances desc;

-- 3.8
explain
select p.serial_number, p.contest_year, COUNT(*) as gear_count
from participant p
join has_to_cook htc on p.cook_id = htc.cook_id and p.serial_number = htc.serial_number and p.contest_year = htc.contest_year
join demands d on htc.recipe_name = d.recipe_name
group by p.serial_number, p.contest_year
order by gear_count desc
limit 5;
-- Create indexes
CREATE INDEX idx_participant_cook_serial_contest ON participant(cook_id, serial_number, contest_year);
CREATE INDEX idx_has_to_cook_cook_serial_contest ON has_to_cook(cook_id, serial_number, contest_year);
CREATE INDEX idx_has_to_cook_recipe_name ON has_to_cook(recipe_name);
CREATE INDEX idx_demands_recipe_name ON demands(recipe_name);
-- Query with FORCE INDEX
EXPLAIN
SELECT 
    p.serial_number, 
    p.contest_year, 
    COUNT(*) AS gear_count
FROM 
    participant p FORCE INDEX (idx_participant_cook_serial_contest)
JOIN 
    has_to_cook htc FORCE INDEX (idx_has_to_cook_cook_serial_contest)
    ON p.cook_id = htc.cook_id AND p.serial_number = htc.serial_number AND p.contest_year = htc.contest_year
JOIN 
    demands d FORCE INDEX (idx_demands_recipe_name)
    ON htc.recipe_name = d.recipe_name
GROUP BY 
    p.serial_number, p.contest_year
ORDER BY 
    gear_count DESC
LIMIT 5;

-- 3.9
SELECT p.contest_year, AVG(i.carbs) AS avg_carbs_per_year
FROM contain c
JOIN recipes r ON c.recipe_name = r.recipe_name
JOIN has_to_cook htc ON c.recipe_name = htc.recipe_name
JOIN participant p ON htc.serial_number = p.serial_number AND htc.contest_year = p.contest_year
JOIN ingredients i ON c.ing_name = i.ing_name
GROUP BY p.contest_year
order by p.contest_year;

-- 3.10
WITH entry_counts AS (
    SELECT 
        r.nationality,
        p.contest_year,
        COUNT(DISTINCT htc.recipe_name) AS num_entries
    FROM 
        participant p
    JOIN 
        has_to_cook htc ON p.serial_number = htc.serial_number AND p.contest_year = htc.contest_year
    JOIN 
        recipes r ON htc.recipe_name = r.recipe_name
    GROUP BY 
        r.nationality, p.contest_year
),
consecutive_years AS (
    SELECT 
        ec1.nationality,
        ec1.contest_year AS year1,
        ec2.contest_year AS year2,
        ec1.num_entries AS entries_year1,
        ec2.num_entries AS entries_year2
    FROM 
        entry_counts ec1
    JOIN 
        entry_counts ec2 ON ec1.nationality = ec2.nationality
                           AND ec1.contest_year = ec2.contest_year - 1
)
SELECT 
    nationality,
    year1,
    year2
FROM 
    consecutive_years
WHERE 
    entries_year1 >= 3 
    AND entries_year2 >= 3 
    AND entries_year1 = entries_year2;
    
-- 3.11
WITH JudgeGrades AS (
    SELECT 
        distinct j.cook_id AS judge_cook_id,
        p.cook_id AS part_cook_id,
        j.serial_number,
        j.contest_year,
        SUM(g.grade) AS total_grade
    FROM 
        judge j
    JOIN 
        grades g ON j.cook_id = g.judge_cook_id AND j.serial_number = g.serial_number 
    JOIN 
        participant p ON g.part_cook_id = p.cook_id AND j.serial_number = p.serial_number 
    GROUP BY 
        j.cook_id, p.cook_id, j.serial_number, j.contest_year
)
SELECT distinct
    j.first_name AS judge_first_name,
    j.last_name AS judge_last_name,
    c.first_name AS cook_first_name,
    c.last_name AS cook_last_name,
    jg.total_grade
FROM 
    JudgeGrades jg
JOIN 
    cooks j ON jg.judge_cook_id = j.cook_id
JOIN 
    cooks c ON jg.part_cook_id = c.cook_id
ORDER BY 
    jg.total_grade DESC
LIMIT 5;

-- 3.12
SELECT DISTINCT contest_year, max_avg_difficulty
FROM (
    SELECT a.contest_year, a.serial_number, a.avg_difficulty AS max_avg_difficulty
    FROM (
        SELECT e.contest_year, e.serial_number, AVG(r.difficulty) AS avg_difficulty
        FROM episode e
        JOIN has_to_cook hc ON e.contest_year = hc.contest_year AND e.serial_number = hc.serial_number
        JOIN recipes r ON hc.recipe_name = r.recipe_name
        GROUP BY e.contest_year, e.serial_number
    ) AS a
    JOIN (
        SELECT contest_year, MAX(avg_difficulty) AS max_avg_difficulty
        FROM (
            SELECT e.contest_year, e.serial_number, AVG(r.difficulty) AS avg_difficulty
            FROM episode e
            JOIN has_to_cook hc ON e.contest_year = hc.contest_year AND e.serial_number = hc.serial_number
            JOIN recipes r ON hc.recipe_name = r.recipe_name
            GROUP BY e.contest_year, e.serial_number
        ) AS avg_diff_per_episode
        GROUP BY contest_year
    ) AS b ON a.contest_year = b.contest_year AND a.avg_difficulty = b.max_avg_difficulty
) AS distinct_max_avg_difficulty
ORDER BY contest_year;

-- 3.13
SELECT 
    e.serial_number,
    e.contest_year,
    SUM(score) AS min_rank_score
FROM
    episode e
JOIN (
    SELECT 
        serial_number,
        contest_year,
        SUM(rank_score) AS score
    FROM
        (
            SELECT 
                j.serial_number,
                j.contest_year,
                c.cook_id,
                (
                    CASE
                        WHEN c.ranks = 'chef' THEN 5
                        WHEN c.ranks = 'sous_chef' THEN 4
                        WHEN c.ranks = 'a_cook' THEN 3
                        WHEN c.ranks = 'b_cook' THEN 2
                        WHEN c.ranks = 'c_cook' THEN 1
                    END
                ) AS rank_score
            FROM 
                judge j
            JOIN cooks c ON j.cook_id = c.cook_id
        UNION ALL
            SELECT 
                p.serial_number,
                p.contest_year,
                c.cook_id,
                (
                    CASE
                        WHEN c.ranks = 'chef' THEN 5
                        WHEN c.ranks = 'sous_chef' THEN 4
                        WHEN c.ranks = 'a_cook' THEN 3
                        WHEN c.ranks = 'b_cook' THEN 2
                        WHEN c.ranks = 'c_cook' THEN 1
                    END
                ) AS rank_score
            FROM 
                participant p
            JOIN cooks c ON p.cook_id = c.cook_id
        ) AS combined_scores
    GROUP BY 
        serial_number,
        contest_year
) AS min_scores ON e.serial_number = min_scores.serial_number AND e.contest_year = min_scores.contest_year
GROUP BY 
    e.serial_number,
    e.contest_year
ORDER BY 
    min_rank_score ASC
LIMIT 1;

-- 3.14
-- help subqueries
select theme_name, h.recipe_name #theme names that appeared in the contest
from has_to_cook h join belongs_to b on h.recipe_name = b.recipe_name
order by theme_name;

select theme_name,count(theme_name) as frequency #counting how many times each theme name appeared in the contest 
from has_to_cook h join belongs_to b on h.recipe_name = b.recipe_name
group by theme_name
order by theme_name;

-- MAIN QUERY
with temp as (
select theme_name,count(theme_name) as frequency
from has_to_cook h join belongs_to b on h.recipe_name = b.recipe_name
group by theme_name
)
select theme_name
from temp
where frequency >= all (
select frequency
from temp
);
-- END

-- 3.15
-- help queries
select h.recipe_name #recipes that took place in the contest
from has_to_cook h join recipes r on h.recipe_name = r.recipe_name;

select c.recipe_name, g.ing_name, g.group_name #recipes that appeared in the contest with their ingredients and the food group they belong
from ((has_to_cook h join recipes r on h.recipe_name = r.recipe_name) 
join contain c on h.recipe_name = c.recipe_name)
join has_group g on g.ing_name = c.ing_name;

-- MAIN QUERY
select group_name
from food_group f
where f.group_name != all (
select g.group_name
from ((has_to_cook h join recipes r on h.recipe_name = r.recipe_name) 
join contain c on h.recipe_name = c.recipe_name)
join has_group g on g.ing_name = c.ing_name
);
-- END