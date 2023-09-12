-- Create a joined table--

select * from Absenteeism_at_work a
left join compensation c on a.ID=c.ID
left join Reasons r on a.Reason_for_absence=r.Number;


---Find the healthiest employees for the bonus
--Criteria to be healthy - Employee should not drink or smoke and must have BMI under 25

select * from Absenteeism_at_work
where Social_drinker=0 
and Social_smoker=0 
and Body_mass_index<25
and Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism_at_work)


---Compensation rate increase for non-smokers
--The allotted budget by HR was 983221 $
--We then calculate the total hours these non-smokers work for in a year i.e- 8*5*52*686 = 1426880
--Now to calculate the percent increase in wage/hr of these employees 983221/1426880 = 0.68
--Amount comes to be $1414.4 per year
select count(*) as NonSmokers from Absenteeism_at_work 
where Social_smoker=0


--Optimizing the join condition to make the dataset for powerBI

select 
a.ID,
r.Reason,
Body_mass_index,
Case when Body_mass_index<18.5 then 'Underweight'
	 when Body_mass_index between 18.5 and 24.9 then 'Healthy'
	 when Body_mass_index between 25 and 30 then 'Overweight'
	 when Body_mass_index>30 then 'Obese'
	 else 'Unknown' end as BMI_Category,
Case when Month_of_absence in (12,1,2) then 'Winter'
	 when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Fall'
	 else 'Unknown' end as Season_Names,
	 Month_of_absence,
	 Day_of_the_week,
	 Transportation_expense,
	 Education,
	 Son,
	 Social_drinker,
	 Social_smoker,
	 Pet,
	 Disciplinary_failure,
	 Age,
	 Work_load_Average_day,
	 Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation c on a.ID=c.ID
left join Reasons r on a.Reason_for_absence=r.Number;