/*
FILE NAME: Homework-1
Created for: BUAN 6337 Predictive Analytics using SAS
Created on : Sept 4, 2020
Created by : Group 4
    Lin, Shih-Min
    Rajasekhar Devineni
    Talreja, Vinita Govind
    Zhou, Wei
*/
/*
Importing data into SAS workspace, all the char variable are fully read with each variable having respective variable length
*/

/*Read the data*/
Data a1;
Infile 'D:\UTDallas\OneDrive - The University of Texas at Dallas\0Coursework\0 BUAN 6337 - PREDICTIVE ANALYTICS USING SAS\HW\car_insurance_19.csv' DLM=',' Missover firstobs=2; 
Length Customer $ 12 State $ 12 Education $ 20 EmploymentStatus $ 15 Gender $ 2 Policy_Type $ 15 Policy $ 15 Sales_Channel $ 12 Vehicle_Class $ 15;
Input Customer$ State$ Customer_Lifetime_Value Response$ Coverage$ Education$ Effective_To_Date$ Employment_Status$ Gender$ Income Location_Code$ Marital_Status$ Monthly_Premium_Auto Months_Since_Last_Claim Months_Since_Policy_Inception Number_of_Open_Complaints Number_of_Policies Policy_Type$ Policy$ Renew_Offer_Type$ Sales_Channel$ Total_Claim_Amount Vehicle_Class$ Vehicle_Size$ ;
Run;


/*Q1*/
Proc freq ;
table Gender Vehicle_Size Vehicle_Class;
Run;
Proc print;
Run;

/*Q2*/
Proc means;
var Customer_Lifetime_Value; class Gender;
Run;
Proc means;
var Customer_Lifetime_Value; class Vehicle_Class;
Run;
Proc means;
var Customer_Lifetime_Value; class Vehicle_Size;
Run;

/*Q3*/
Proc ttest;
var Customer_Lifetime_Value;
class Vehicle_Size; where Vehicle_Size in ("Large", "Medsize");
Run;

/*Q4*/
Proc ttest;
var Customer_Lifetime_Value;
class Gender; 
Run;

/*Q5*/
Proc ANOVA;
class Sales_Channel; 
model Customer_Lifetime_Value=Sales_Channel;
Run;

/*Q6*/
DATA A2;
SET a1;
if Marital_Status="Single" then status=0;
if Marital_Status="Married" then status=1;
if Marital_Status="Divorced" then status=2;
if Education="High School or Below" then Education_level=0;
if Education="College" then Education_level=1;
if Education="Bachelor" then Education_level=2;
if Education="Master" then Education_level=3;
if Education="Doctor" then Education_level=4;
if Employment_status="Disabled" then Employ_status=0;
if Employment_status="Employed" then Employ_status=1;
if Employment_status="Unemployed" then Employ_status=2;
if Employment_status="Retired" then Employ_status=3;
if Employment_status="Medical Leave" then Employ_status=4;
if Location_Code="Rural" then LC=0;
if Location_Code="Urban" then LC=2;
if Location_Code="Suburban" then LC=1;
run;
    
DATA A2;
SET a1;
if Marital_Status="Single" then status=0;
if Marital_Status="Married" then status=1;
if Marital_Status="Divorced" then status=2;
if Education="High School or Below" then Education_level=0;
if Education="College" then Education_level=1;
if Education="Bachelor" then Education_level=2;
if Education="Master" then Education_level=3;
if Education="Doctor" then Education_level=4;
run;

proc reg data=a2;
model customer_lifetime_value = income status Education_level;
run;





Proc REG data=a2;
model Customer_Lifetime_Value=Education_level Income status LC Employ_status;
Run;

Proc REG data=a2;
model Customer_Lifetime_Value=Education_level Income status;
Run;

/*Q7*/
Proc freq ;
tables Renew_Offer_Type* Response/chisq;
Run;

/*Q8*/
Proc ANOVA;
class Renew_Offer_Type; 
model Customer_Lifetime_Value=Renew_Offer_Type;
means Renew_Offer_Type/TUKEY CLDIFF;
Run;

/*Q9*/
Proc means;
var Customer_Lifetime_Value; class Renew_Offer_Type State;
Run;

/*Q10*/
Proc ANOVA plots=none;
class Sales_Channel; 
model Customer_Lifetime_Value=Sales_Channel;
means Sales_Channel/TUKEY CLDIFF;
Run;

Proc ANOVA;
class Policy_Type; 
model Customer_Lifetime_Value=Policy_Type;
means Policy_Type/TUKEY CLDIFF;
Run;

Proc ttest;
var Customer_Lifetime_Value;
class Location_Code; where Location_Code in ("Rural", "Urban");
Run;

