library(XML)

url <- "http://www.pro-football-reference.com/play-index/tgl_finder.cgi?request=1&match=game&year_min=1990&year_max=2014&game_type=R&playoff_round=&game_num_min=0&game_num_max=99&week_num_min=0&week_num_max=99&game_day_of_week=&game_time=&time_zone=&game_location=&surface=&roof=&stadium_id=&temperature_gtlt=lt&temperature=&game_result=&overtime=&league_id=&team_id=&team_conf_id=&team_div_id=&opp_id=&opp_conf_id=&opp_div_id=&team_off_scheme=&team_def_align=&opp_off_scheme=&opp_def_align=&conference_game=&division_game=&tm_is_playoff=&opp_is_playoff=&tm_is_winning=&opp_is_winning=&tm_scored_first=&tm_led=&tm_trailed=&c1stat=rush_att&c1comp=gt&c1val=0&c2stat=rush_yds_per_att&c2comp=gt&c2val=-100&c3stat=points&c3comp=gt&c3val=0&c4stat=turnovers&c4comp=gt&c4val=0&c5comp=&c5gtlt=lt&c6mult=1.0&c6comp=&order_by=game_date"
skipRows = c(21,42,63,84)
tables <- readHTMLTable(url, skip.rows = skipRows)
x <- 1:122
offset = 100
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
stats <- tables[[which.max(n.rows)]]

for (i in seq(along=x))
  {
  url <- paste0(url, "&offset=", offset)
  tables <- readHTMLTable(url, skip.rows = skipRows)
  stats <- rbind(stats, tables[[which.max(n.rows)]])  
  offset <- offset + 100 
  }

colnames(stats) <- c("Rank", "Team", "Year", "Date", "Time", "LocalTime", "Home", "WeekNum", "Opponent", "GameNum", "DayOfWeek", "Result", "OT", "PointsFor", "PointsAgainst", "PointDiff", "TotalPoints", "RushAtt", "RushYds", "RushYPA", "RushTD", "TotalYards", "OffPlays", "YardsPerPlay", "DefPlays", "YardsPerPlayAllowed", "Turnovers", "TimeOfPossession")