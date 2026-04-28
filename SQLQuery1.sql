WITH LatestOrder AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS LastOrder
    FROM Orders
    GROUP BY CustomerID
)

SELECT 
    CASE 
        WHEN DATEDIFF(DAY, LastOrder, GETDATE()) > 90 THEN 'At Risk'
        ELSE 'Active'
    END AS Status,
    
    COUNT(*) AS CustomerCount,
    
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS ChurnPercentage

FROM LatestOrder
GROUP BY 
    CASE 
        WHEN DATEDIFF(DAY, LastOrder, GETDATE()) > 90 THEN 'At Risk'
        ELSE 'Active'
    END;