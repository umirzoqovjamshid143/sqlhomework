WITH RoutePaths AS (
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        ArrivalCity AS CurrentCity,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    SELECT 
        rp.DepartureCity,
        r.ArrivalCity,
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)),
        r.ArrivalCity,
        rp.Cost + r.Cost
    FROM #Routes r
    JOIN RoutePaths rp ON r.DepartureCity = rp.CurrentCity
)
SELECT * FROM RoutePaths;
