#THE PADS
#HackerRank_Challenge

--Generate the following two result sets:
--1-Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
--2-Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

    --There are a total of [occupation_count] [occupation]s.
--where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

SELECT concat(Name,'(',SUBSTRING(OCCUPATION, 1, 1),')')
FROM OCCUPATIONS ORDER BY NAME asc;

SELECT concat('There are a total of ',count(*),' ',lower(occupation),(if(count(*)>1,'s','')),'.' )
from OCCUPATIONS group by OCCUPATION order by count(occupation) asc;

