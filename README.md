# Cross-Check

Cross-Check is a system that uses data from the National Hockey League to analyze team performance for specific seasons and across seasons. We want to see who the best and worst performers are, as well as be able to pull statistics for individual teams.

## How to install it

1. [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) in your machine.
2. [Clone](https://help.github.com/en/articles/cloning-a-repository) this repo 
3. Once you have your local clone, enter the following in your terminal:
```
$ cd cross_check
$ bundle install
```

## How to generate a web page

To generate a web page dynamically enter in the terminal:

```
$ ruby page_generator.rb 
$ open site/index.html
```
Note: Currently, the website only shows team statistics for Boston Bruins (`team_id = 6`) and season statistics for season `20172018`.

## How to use it

The `StatTracker` class provides the following information:

### Game Statistics

| Method | Description | Return Value |
| --- | --- | --- |
| `highest_total_score` | Highest sum of the winning and losing teams’ scores | Integer
| `lowest_total_score` | Lowest sum of the winning and losing teams’ scores | Integer
| `biggest_blowout` | Highest difference between winner and loser | Integer
| `percentage_home_wins` | Percentage of games that a home team has won (rounded to the nearest 100th) | Float
| `percentage_visitor_wins` | Percentage of games that a visitor has won (rounded to the nearest 100th) | Float
| `count_of_games_by_season` | A hash with season names (e.g. 20122013) as keys and counts of games as values | Hash
| `average_goals_per_game` | Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th) | Float |
| `average_goals_by_season` | Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as a key (rounded to the nearest 100th) | Hash

### League Statistics

| Method | Description | Return Value |
| --- | --- | --- |
| `count_of_teams` | Total number of teams in the data. | Integer
| `best_offense` | Name of the team with the highest average number of goals scored per game across all seasons. | String
| `worst_offense` | Name of the team with the lowest average number of goals scored per game across all seasons. | String
| `best_defense` | Name of the team with the lowest average number of goals allowed per game across all seasons. | String
| `worst_defense` | Name of the team with the highest average number of goals allowed per game across all seasons. | String
| `highest_scoring_visitor` | Name of the team with the highest average score per game across all seasons when they are away. | String
| `highest_scoring_home_team` | Name of the team with the highest average score per game across all seasons when they are home. | String |
| `lowest_scoring_visitor` | Name of the team with the lowest average score per game across all seasons when they are a visitor.	 | String
| `lowest_scoring_home_team` | Name of the team with the lowest average score per game across all seasons when they are at home. | String
| `winningest_team` | Name of the team with the highest win percentage across all seasons. | String |
| `best_fans` | Name of the team with biggest difference between home and away win percentages. | String
| `worst_fans` | List of names of all teams with better away records than home records. | Array

### Team Statistics
Each of the methods below take a `team_id` as an argument

| Method | Description | Return Value |
| --- | --- | --- |
| `team_info` | A hash with key/value pairs for each of the attributes of a team. | Hash
| `best_season` | Season with the highest win percentage for a team. | Integer
| `worst_season` | Season with the lowest win percentage for a team. | Integer
| `average_win_percentage` | Average win percentage of all games for a team. | Float
| `most_goals_scored` | Highest number of goals a particular team has scored in a single game. | Integer
| `fewest_goals_scored` | Lowest numer of goals a particular team has scored in a single game. | Integer
| `favorite_opponent` | Name of the opponent that has the lowest win percentage against the given team. | String |
| `rival` | Name of the opponent that has the highest win percentage against the given team. | String
| `biggest_team_blowout` | Biggest difference between team goals and opponent goals for a win for the given team. | Integer
| `worst_loss` | Biggest difference between team goals and opponent goals for a loss for the given team. | Integer |
| `head_to_head` | Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value. | Hash
| `seasonal_summary` | For each season that the team has played, a hash that has two keys (`:regular_season` and `:postseason`), that each point to a hash with the following keys: `:win_percentage`, `:total_goals_scored`, `:total_goals_against`, `:average_goals_scored`, `:average_goals_against`. | Hash

### Season Statistics
Each of the methods below take a `season_id` as an argument. For the methods in this section *only*, the goals  recorded in the GameTeams CSV file are used.

| Method | Description | Return Value |
| --- | --- | --- |
| `biggest_bust` | Name of the team with the biggest decrease between regular season and postseason win percentage. | String
| `biggest_surprise` | Name of the team with the biggest increase between regular season and postseason win percentage. | String
| `winningest_coach` | Name of the Coach with the best win percentage for the season | String
| `worst_coach` | Name of the Coach with the worst win percentage for the season | String
| `most_accurate_team` | Name of the Team with the best ratio of shots to goals for the season | String
| `least_accurate_team` | Name of the Team with the worst ratio of shots to goals for the season | String
| `most_hits` | Name of the Team with the most hits in the season | String |
| `fewest_hits` | Name of the Team with the fewest hits in the season | String
| `power_play_goal_percentage` | Percentage of goals that were power play goals for the season (rounded to the nearest 100th) | Float


## Built With
* Ruby 2.4.1

## Testing
All test are done with RSpec with a 100% code coverage (calculated with [SimpleCov](https://github.com/colszowka/simplecov))

To run all tests, enter in your terminal:
```
$ cd cross_check
$ rspec
```

To run a single test:
```
$ cd cross_check
$ rspec spec/stat_tracker_spec.rb
```
