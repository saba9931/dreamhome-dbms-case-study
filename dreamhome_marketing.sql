-- DREAMHOME MARKETING DEPARTMENT SQL SCRIPT

-- 1. CAMPAIGN TABLE
CREATE TABLE Campaign (
    Campaign_ID VARCHAR(10) PRIMARY KEY,
    Campaign_Name VARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Budget DECIMAL(10, 2)
);

-- 2. NEWSPAPER TABLE
CREATE TABLE Newspaper (
    Newspaper_Name VARCHAR(100) PRIMARY KEY,
    Contact_Person VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(150)
);

-- 3. PROPERTY TABLE
CREATE TABLE Property (
    Property_ID VARCHAR(10) PRIMARY KEY,
    Address VARCHAR(150),
    Type VARCHAR(50),
    Monthly_Rent DECIMAL(10, 2)
);

-- 4. ADVERTISEMENT TABLE
CREATE TABLE Advertisement (
    Ad_ID VARCHAR(10) PRIMARY KEY,
    Property_ID VARCHAR(10),
    Newspaper_Name VARCHAR(100),
    Ad_Date DATE,
    Ad_Cost DECIMAL(10, 2),
    Publishing_Schedule VARCHAR(50),
    Campaign_ID VARCHAR(10),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID),
    FOREIGN KEY (Newspaper_Name) REFERENCES Newspaper(Newspaper_Name),
    FOREIGN KEY (Campaign_ID) REFERENCES Campaign(Campaign_ID)
);

-- 5. AD PERFORMANCE REPORT
CREATE TABLE Ad_Performance_Report (
    Report_ID VARCHAR(10) PRIMARY KEY,
    Ad_ID VARCHAR(10),
    Reach INT,
    Clicks INT,
    Engagement_Score DECIMAL(5,2),
    Cost_Per_Lead DECIMAL(10,2),
    FOREIGN KEY (Ad_ID) REFERENCES Advertisement(Ad_ID)
);

-- 6. BRAND SPECIALIST
CREATE TABLE Brand_Specialist (
    Employee_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Role VARCHAR(50)
);

-- 7. CREATIVE ASSET
CREATE TABLE Creative_Asset (
    Asset_ID VARCHAR(10) PRIMARY KEY,
    File_Name VARCHAR(100),
    Format VARCHAR(10),
    Linked_Ad_ID VARCHAR(10),
    Created_By VARCHAR(10),
    FOREIGN KEY (Linked_Ad_ID) REFERENCES Advertisement(Ad_ID),
    FOREIGN KEY (Created_By) REFERENCES Brand_Specialist(Employee_ID)
);

-- 8. VENDOR CONTRACT
CREATE TABLE Vendor_Contract (
    Contract_ID VARCHAR(10) PRIMARY KEY,
    Newspaper_Name VARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Rate_Per_Column DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (Newspaper_Name) REFERENCES Newspaper(Newspaper_Name)
);

-- 9. MEDIA BUDGET
CREATE TABLE Media_Budget (
    Budget_ID VARCHAR(10) PRIMARY KEY,
    Campaign_ID VARCHAR(10),
    Allocated_Amount DECIMAL(10, 2),
    Actual_Spend DECIMAL(10, 2),
    FOREIGN KEY (Campaign_ID) REFERENCES Campaign(Campaign_ID)
);

-- =========================================================
-- ✅ SAMPLE QUERIES
-- =========================================================

-- Show all advertisements with newspaper and property
SELECT A.Ad_ID, P.Address AS Property, N.Newspaper_Name, A.Ad_Date, A.Ad_Cost
FROM Advertisement A
JOIN Property P ON A.Property_ID = P.Property_ID
JOIN Newspaper N ON A.Newspaper_Name = N.Newspaper_Name;

-- List campaigns with budget and actual spend
SELECT C.Campaign_Name, M.Allocated_Amount, M.Actual_Spend
FROM Campaign C
JOIN Media_Budget M ON C.Campaign_ID = M.Campaign_ID;

-- Show ad performance by engagement score
SELECT A.Ad_ID, R.Engagement_Score
FROM Advertisement A
JOIN Ad_Performance_Report R ON A.Ad_ID = R.Ad_ID
ORDER BY R.Engagement_Score DESC;

-- List creative assets by ad
SELECT CA.Asset_ID, CA.File_Name, B.Name AS Created_By
FROM Creative_Asset CA
JOIN Brand_Specialist B ON CA.Created_By = B.Employee_ID;

-- Check vendor contracts and their status
SELECT V.Contract_ID, N.Newspaper_Name, V.Rate_Per_Column, V.Status
FROM Vendor_Contract V
JOIN Newspaper N ON V.Newspaper_Name = N.Newspaper_Name;