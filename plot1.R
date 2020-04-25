setwd("C:\\Users\\Intel\\Documents\\Datasets\\exdata_data_NEI_data")

# Read the rds files as shown in the instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the column names to see which database is required
colnames(NEI)
colnames(SCC)

# Calculating the total emissions with respect to the years
totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)

# Creating the fig
png("plot1.png")
barplot(height = totalEmissions,
        col = "blue",
        xlab = "Year",
        ylab = "Total Emission",
        main = "Total Emissions for PM2.5 from the year 1998 to 2008")
dev.off()