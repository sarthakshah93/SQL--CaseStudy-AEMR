/* Energy stability is one of the key themes the AEMR management team cares about. To ensure energy security and reliability, AEMR needs to understand the following:
1) What are the most common outage types and how long do they tend to last?
2) How frequently do the outages occur?
3) Are there any energy providers that have more outages than their peers which may indicate that these providers are unreliable? */


1.1 
SELECT Status, Reason, COUNT(Start_Time) as Total_Number_Outage_Events
FROM AEMR
WHERE Status = 'Approved'
  AND
	Start_Time in
    (SELECT Start_Time
    FROM AEMR
    WHERE YEAR(Start_Time = '2016'))
 GROUP BY Reason
 ORDER BY Total_Number_Outage_Events
 
 
 1.2
SELECT Status, Reason, COUNT(Start_Time) as Total_Number_Outage_Events
FROM AEMR
WHERE Status = 'Approved'
  AND
	Start_Time in
    (SELECT Start_Time
    FROM AEMR
    WHERE YEAR(Start_Time = '2016'))
 GROUP BY Reason
 ORDER BY Total_Number_Outage_Events 
 

1.3
SELECT COUNT(*) as Total_Number_Outage_Events, Status, Reason 
FROM AEMR
WHERE Status = 'Approved' 
  AND 
    Start_Time in 
    (SELECT Start_Time 
      FROM AEMR 
      WHERE YEAR(Start_Time) = '2017')
GROUP BY Reason
ORDER BY Reason

1.5
SELECT Status, Reason, COUNT(Start_Time) as Total_Number_Outage_Events, ROUND(AVG((TIMESTAMPDIFF(MINUTE, Start_Time, End_Time) / 60) / 24), 2) AS Average_Outage_Duration_Time_Days, YEAR(Start_Time) AS Year
FROM AEMR
WHERE STATUS = 'Approved'
GROUP BY REASON, Year
ORDER BY Year, Reason

2.1
SELECT Status, Reason, COUNT(Start_Time) as Total_Number_Outage_Events, MONTH(Start_Time) AS Month 
FROM AEMR
WHERE STATUS = 'Approved' AND Start_Time in (SELECT Start_Time FROM AEMR WHERE YEAR(Start_Time) = '2016')
GROUP BY REASON, Month
ORDER BY Reason, Month

2.2
SELECT Status, Reason, COUNT(Start_Time) as Total_Number_Outage_Events, MONTH(Start_Time) AS Month 
FROM AEMR
WHERE STATUS = 'Approved' AND Start_Time in (SELECT Start_Time FROM AEMR WHERE YEAR(Start_Time) = '2017')
GROUP BY REASON, Month
ORDER BY Reason, Month

2.3
SELECT Status, COUNT(Start_Time) as Total_Number_Outage_Events, MONTH(Start_Time) AS Month, Year(Start_Time) as Year 
FROM AEMR
WHERE STATUS = 'Approved' AND Start_Time in (SELECT Start_Time FROM AEMR WHERE YEAR(Start_Time) = '2017' OR YEAR(Start_Time) = '2016')
GROUP BY Month, Year
ORDER BY MOnth, Year

3.1
SELECT COUNT(Start_Time) as Total_Number_Outage_Events, Participant_Code, Status, Year(Start_Time) as Year 
FROM AEMR
WHERE STATUS = 'Approved' 
GROUP BY Participant_Code, Year
ORDER BY Year, Participant_Code

3.2
SELECT Participant_Code, Status, YEAR(Start_Time) AS Year, ROUND(AVG((TIMESTAMPDIFF(MINUTE, Start_Time, End_Time) / 60) / 24), 2) AS Average_Outage_Duration_Time_Days
FROM AEMR
WHERE STATUS = 'Approved'
GROUP BY Participant_Code, Year
ORDER BY Average_Outage_Duration_Time_Days DESC

3.3
SELECT 
          SUM(CASE WHEN Reason = 'Forced' THEN 1
          ELSE 0
          END) AS Total_Number_Forced_Outage_Events, 
          COUNT(*) as Total_Number_Outage_Events,
          ROUND(SUM(CASE WHEN Reason = 'Forced' THEN 1
          ELSE 0
          END) / Count(*) * 100, 2) as Forced_Outage_Percentage, Year(Start_Time) as Year

FROM AEMR
WHERE STATUS = 'Approved' 
GROUP BY Year
ORDER BY Year, Year
