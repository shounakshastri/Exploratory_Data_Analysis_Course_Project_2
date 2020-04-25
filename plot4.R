setwd("C:\\Users\\Intel\\Documents\\Datasets\\exdata_data_NEI_data")

# Read the rds files as shown in the instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the column names to see which database is required
colnames(NEI)
colnames(SCC)

# Creating a new variable with data for coal
combustionData <- grepl("comb", SCC$Short.Name, ignore.case=TRUE)
coalSCC <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalCombustionData <- SCC[combustionData & coalSCC, ]
coalNEI <- NEI[NEI$SCC %in% coalCombustionData$SCC, ]

# Calculating the total emissions due to coal combustion 
# with respect to the years
totalCoalEmissions <- tapply(coalNEI$Emissions,
                                      coalNEI$year,
                                      sum)

# Creating the fig
png("plot4.png")
barplot(totalCoalEmissions,
        col = "blue",
        xlab = "Year",
        ylab = "Emissions",
        main = "Total emissions due to coal combustion")
dev.off()