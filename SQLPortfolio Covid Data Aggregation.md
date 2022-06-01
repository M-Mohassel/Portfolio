

# Covid 19 Data Exploration 
### Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types



`SELECT *
FROM [Portfolio Project Covid]..CovidDeath
WHERE continent is not null
ORDER BY 3,4`


`SELECT *
FROM [Portfolio Project Covid]..CovidVac
ORDER BY 3,4`




`SELECT Location , date , total_cases , new_cases, total_deaths, population
FROM [Portfolio Project Covid]..CovidDeath
ORDER BY 1,2`


### Looking at Total_cases vs Total_Deaths:
`SELECT Location, date, total_cases,total_deaths , (total_deaths/total_cases)*100 AS Death_Percentage
FROM [Portfolio Project Covid]..CovidDeath
WHERE location LIKE '%germany%'
ORDER BY 1,2`

### Looking at Total cases vs Populiation:

`SELECT Location, date,population, total_cases , (total_cases/population)*100 AS Total_cases_Percentage
FROM [Portfolio Project Covid]..CovidDeath
WHERE location LIKE '%germany%'
ORDER BY 1,2`

### Looking at countries with the highest infection rate:
`SELECT Location, population, MAX(total_cases) as Highest_Infection_Count , MAX((total_cases/population))*100 AS percentage_
FROM [Portfolio Project Covid]..CovidDeath
WHERE continent is not null
GROUP BY location,population
ORDER BY 4 DESC`


### Countries with highest death per population:
`SELECT Location,MAX (cast(total_deaths as int)) AS total_death
FROM [Portfolio Project Covid]..CovidDeath
WHERE continent is not null
GROUP BY location
ORDER BY 2 desc`


### Showing continent with highest death count per population:
`SELECT continent,MAX (cast(total_deaths as int)) AS total_death
FROM [Portfolio Project Covid]..CovidDeath
WHERE continent is not null
GROUP BY continent
ORDER BY 2 desc`

### Global numbers:
`SELECT SUM (new_cases) AS Total_cases ,SUM(CAST(new_deaths as int)) AS Total_Deaths,SUM(CAST(new_deaths as int)) / SUM (new_cases) *100 AS Death_Percentage
FROM [Portfolio Project Covid]..CovidDeath
WHERE continent is not null
ORDER BY 1,2`



### Looking at Total Population vs Vaccinations

`SELECT death.continent, death.location , death.date , death.population,vac.new_vaccinations
,SUM (CONVERT (BIGINT ,vac.new_vaccinations )) OVER (PARTITION BY death.location ORDER BY death.location ,CONVERT (DATE,death.date)) AS Rolling_People_Vaccinated
FROM [Portfolio Project Covid]..CovidDeath death
JOIN [Portfolio Project Covid]..CovidVac vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent is not null
ORDER BY 2,3`


### USING CTE:
`WITH POPvsVAC (Continent,location,Date,population,new_vaccinations,Rolling_People_Vaccinated)
as 
(
SELECT death.continent, death.location , death.date , death.population,vac.new_vaccinations
,SUM (CONVERT (BIGINT ,vac.new_vaccinations )) OVER (PARTITION BY death.location ORDER BY death.location ,CONVERT (DATE,death.date)) AS Rolling_People_Vaccinated
FROM [Portfolio Project Covid]..CovidDeath death
JOIN [Portfolio Project Covid]..CovidVac vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent is not null
)
Select *,(Rolling_People_Vaccinated/population)*100 as PercentPopulationVaccinated
FROM POPvsVAC`



### Using Temp Table to perform Calculation on Partition By in previous query

`DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date date,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select death.continent, death.location , death.date , death.population,vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by death.Location Order by death.location, CONVERT (DATE,death.date)) as RollingPeopleVaccinated

FROM [Portfolio Project Covid]..CovidDeath death
JOIN [Portfolio Project Covid]..CovidVac vac
	On death.location = vac.location
	and death.date = vac.date

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated`



### Creating a View

`Create View PercentPopulationVaccinatedview as 
SELECT death.continent, death.location , death.date , death.population,vac.new_vaccinations
,SUM (CONVERT (BIGINT ,vac.new_vaccinations )) OVER (PARTITION BY death.location ORDER BY death.location ,CONVERT (DATE,death.date)) AS Rolling_People_Vaccinated
FROM [Portfolio Project Covid]..CovidDeath death
JOIN [Portfolio Project Covid]..CovidVac vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent is not null

select *
FROM PercentPopulationVaccinatedview`
