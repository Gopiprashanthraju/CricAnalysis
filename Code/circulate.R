library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/IND vs AUS/ODI"
year_folders <- list.files(base_dir)

batsman_scores <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
bowler_scores <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv")
for (year in year_folders){
    json_files <- list.files(paste(base_dir, year, sep = "/"))
    for (json_file in json_files){
        if (json_file == "CSVs" || json_file == "65244.json"){
            next()
        }
        file_path <- paste(base_dir, year, json_file, sep = "/")
        json_data <- read_json(path=file_path)
        print(file_path)
        
        # Send file_path to conversion.r and get converted data
        source("D:/Minor_Project-II/Code/conversion.r")
        csv_converted <- convert_to_csv(file_path)
        if (nrow(csv_converted)==0){
            next()
        }
        source("D:/Minor_Project-II/Code/PlayerScores.r")
        batsman_bowler_data<-player_scores(csv_converted)
        source("D:/Minor_Project-II/Code/ScoreBoard.R")
        sixesAndFours<-data.frame(ScoreBoard(csv_converted))
        # print(batsman_bowler_data)
        # print(sixesAndFours)
        ## updating batsman runs,balls,out
    #     for(i in 1:nrow(batsman_bowler_data[[1]])){
    #         row = batsman_bowler_data[[1]][i,]
    #         row$runs = as.numeric(row$runs)
    #         row$out = as.numeric(row$out)
    #         row$balls = as.numeric(row$balls)
    #         if(row$player %in% batsman_scores$player){
    #             batsman_scores[batsman_scores$player == row$player, "runs"] <- batsman_scores[batsman_scores$player == row$player, "runs"] + row$runs
    #             batsman_scores[batsman_scores$player == row$player, "out"] <- batsman_scores[batsman_scores$player == row$player, "out"] + row$out
    #             batsman_scores[batsman_scores$player == row$player, "balls"] <- batsman_scores[batsman_scores$player == row$player, "balls"] + row$balls
    #             batsman_data[batsman_data$player == row$player, "sixes"] <- batsman_data[batsman_data$player == row$player, "sixes"] + row$six
    #             batsman_data[batsman_data$player == row$player, "fours"] <- batsman_data[batsman_data$player    == row$player, "fours"] + row$four 
    #     }
    #     else{
    #         batsman_scores <- rbind(batsman_scores, data.frame(player = row$player, runs = row$runs, out = row$out, balls = row$balls, country = row$country, strike_rate =0, batting_average=0))
    # }
    # }
    ##updating batsman sixes and fours
    for (i  in 1:nrow(sixesAndFours)) {
        row = sixesAndFours[i,]
        # print(row$player)
        if (row$player %in% batsman_scores$player) {

            batsman_scores[batsman_scores$player == row$player, "sixes"] <- batsman_scores[batsman_scores$player == row$player, "sixes"] + as.numeric(row$sixes)
            batsman_scores[batsman_scores$player == row$player, "fours"] <- batsman_scores[batsman_scores$player == row$player, "fours"] + as.numeric(row$fours)
        }
    }
        
    #     for(i in 1:nrow(batsman_bowler_data[[2]])){
    #         row = batsman_bowler_data[[2]][i,]
    #         row$score = as.numeric(row$score)
    #         row$wickets = as.numeric(row$wickets)
    #         row$balls = as.numeric(row$balls)
    #         row$extra = as.numeric(row$extra)
    #         if(row$player %in% bowler_scores$player){
    #             bowler_scores[bowler_scores$player == row$player, "score"] <- bowler_scores[bowler_scores$player == row$player, "score"] + row$score
    #             bowler_scores[bowler_scores$player == row$player, "wickets"] <- bowler_scores[bowler_scores$player == row$player, "wickets"] + row$wickets
    #             bowler_scores[bowler_scores$player == row$player, "extra"] <- bowler_scores[bowler_scores$player == row$player, "extra"] + row$extra
    #             bowler_scores[bowler_scores$player == row$player, "balls"] <- bowler_scores[bowler_scores$player == row$player, "balls"] + row$balls
    #     }
    #     else{
    #         bowler_scores <- rbind(bowler_scores, data.frame(player = row$player, score = row$score, wickets = row$wickets, extra = row$extra,balls = row$balls, country = row$country))
    # }
    # }

}
}

# print(batsman_scores)
# print(bowler_scores)
#writing data to csv
# write.csv(batsman_scores, "D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv", row.names = FALSE)
# write.csv(bowler_scores, "D:/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv", row.names = FALSE)