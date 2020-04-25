setwd("C:\\Users\\Intel\\Documents\\Datasets\\exdata_data_NEI_data")

# Read the rds files as shown in the instructions
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking the column names to see which database is required
colnames(NEI)
colnames(SCC)

# Creating a new variable with data of Baltimore city
emissionsBaltimore <- NEI[NEI$fips == "24510", ]
emissionsLACounty <- NEI[NEI$fips == "06037", ]

# Creating new variables with data for Baltimore City and LA County
vehicleData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicleData, ]
vehicleEmissionsBaltimore <- emissionsBaltimore[emissionsBaltimore$SCC %in% vehicleSCC$SCC, ]
vehicleEmissionsLACounty <- emissionsBaltimore[emissionsLACounty$SCC %in% vehicleSCC$SCC, ]

# Calculating the total vehicle emissions in Baltimore and LA County
# with respect to the years
totalVehicleEmissionsBaltimore <- tapply(vehicleEmissionsBaltimore$Emissions,
                                         vehicleEmissionsBaltimore$year,
                                         sum)


totalVehicleEmissionsLACounty <- tapply(vehicleEmissionsLACounty$Emissions,
                                         vehicleEmissionsLACounty$year,
                                         sum)

combinedEmissions <- cbind(totalVehicleEmissionsBaltimore, totalVehicleEmissionsLACounty)

# Creating the fig
png("plot6.png")
barplot(combinedEmissions,
        col = colors()[c(30, 32, 33, 35)],
        xlab = "Year",
        ylab = "Emissions",
        legend.text = c("1999", "2002", "2005", "2008"),
        beside = TRUE,
        main = "Total emissions from Vehicles in Baltimore and LA County")
dev.off()
