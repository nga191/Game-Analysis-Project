-- Tính KPI chính
SELECT COUNT(UserID) as total_user,
	   SUM(InAppPurchaseAmount) as total_revenue, 
	   AVG(InAppPurchaseAmount) as avg_revenue,
	   SUM(SessionCount) as total_session,
	   AVG(age) as avg_age, 
	   AVG(firstpurchasedaysafterinstall) as avg_day_purchase_after_install
FROM data_game

-- Tính doanh thu theo quốc gia
SELECT SUM(InAppPurchaseAmount) as total_revenue, country
FROM data_game
GROUP BY country
ORDER BY total_revenue desc

-- Tính số tiền chi ra của người dùng theo segment
SELECT SpendingSegment, 
	   SUM(InAppPurchaseAmount) as total_purchase_segment
FROM data_game
GROUP BY SpendingSegment
ORDER BY total_purchase_segment desc

-- Tính tốc độ tăng trưởng số tiền chi ra theo tháng
SELECT 
    FORMAT(LastPurchaseDate, 'yyyy-MM') AS purchase_month,
    SUM(InAppPurchaseAmount) AS revenue,
    (SUM(InAppPurchaseAmount) - LAG(SUM(InAppPurchaseAmount)) 
        OVER (ORDER BY FORMAT(LastPurchaseDate, 'yyyy-MM')))
        / NULLIF(LAG(SUM(InAppPurchaseAmount)) 
        OVER (ORDER BY FORMAT(LastPurchaseDate, 'yyyy-MM')), 0) 
        AS growth_purchase_by_month
FROM data_game
GROUP BY FORMAT(LastPurchaseDate, 'yyyy-MM')
ORDER BY purchase_month;

-- Dữ liệu chi tiết theo thể loại game
SELECT gamegenre, COUNT(userid) as total_user, SUM(InAppPurchaseAmount) as total_purchase, AVG(sessioncount) as avg_session, AVG(age) as avg_age, AVG(firstpurchasedaysafterinstall) as avg_first_purchase_day, AVG(averagesessionlength) as avg_session_length
FROM data_game
GROUP BY GameGenre

-- All data
SELECT *
FROM data_game