setwd("C:\\Users\\Intel\\Documents\\Datasets\\exdata_data_NEI_data")

# Read the rds files as shown in the instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the column names to see which database is required
colnames(NEI)
colnames(SCC)

# Creating a new variable with data of Baltimore city
emissionsBaltimore <- NEI[NEI$fips == "24510", ]

# Creating a new variable with data for coal
vehicleData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicleData, ]
vehicleEmissions <- emissionsBaltimore[emissionsBaltimore$SCC %in% vehicleSCC$SCC, ]

# Calculating the total emissions due to coal combustion 
# with respect to the years
totalVehicleEmissions <- tapply(vehicleEmissions$Emissions,
                             vehicleEmissions$year,
                             sum)

# Creating the fig
png("plot5.png")
barplot(totalVehicleEmissions,
        col = "blue",
        xlab = "Year",
        ylab = "Emissions",
        main = "Total emissions from Vehicles in Baltimore city")
dev.off()