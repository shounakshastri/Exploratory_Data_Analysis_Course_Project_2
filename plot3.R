setwd("C:\\Users\\Intel\\Documents\\Datasets\\exdata_data_NEI_data")

# Read the rds files as shown in the instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the column names to see which database is required
colnames(NEI)
colnames(SCC)

# Creating a new variable with data of Baltimore city
emissionsBaltimore <- NEI[NEI$fips == "24510", ]

# Calculating the total emissions with respect to the years
totalEmissionsBaltimoreType <- aggregate(Emissions ~ year + type,
                                         emissionsBaltimore,
                                         sum)

# Creating the fig
library(ggplot2)

png("plot3.png")
g <- ggplot(totalEmissionsBaltimoreType, aes(year, Emissions, color = type))
g <- g + geom_line(size = 1.5) + xlab("year") +
    ylab(expression("Emissions")) +
    ggtitle('Total Emissions in Baltimore City from 1999 to 2008')
print(g)
dev.off()