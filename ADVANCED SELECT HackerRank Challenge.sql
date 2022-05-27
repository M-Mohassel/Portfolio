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




  
# Occupations  
  
--Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.  
  
--***Note:*** Print NULL when there are no more names corresponding to an occupation.  


SELECT
    Doctor,
    Professor,
    Singer,
    Actor
FROM
    (SELECT 
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) R_N,
         Name,
         Occupation 
     FROM 
         Occupations
    ) AS source 
PIVOT
(
max(Name) FOR occupation IN (Doctor,Professor,Singer,Actor) 
)as pvt
ORDER BY R_N

#Binary Tree Nodes
--You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

--Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
--Root: If node is root node.
--Leaf: If node is leaf node.
--Inner: If node is neither root nor leaf node.


SELECT N,
CASE
   WHEN P IS NULL THEN 'Root'
   WHEN (SELECT COUNT(*) FROM BST WHERE B.N=P)>0 THEN 'Inner'
   ELSE 'Leaf'
END AS PLACE
FROM BST as B
ORDER BY N;
