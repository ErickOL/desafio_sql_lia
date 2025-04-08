-- Média de dependentes por departamento
SELECT 
    d.nome AS departamento,
    ROUND(AVG(qtd_dependentes), 2) AS media_dependentes
FROM (
    SELECT 
        e.lotacao,
        e.matr,
        COUNT(dp.matr) AS qtd_dependentes
    FROM empregado e
    LEFT JOIN dependente dp ON e.matr = dp.matr
    GROUP BY e.lotacao, e.matr
) AS subquery
INNER JOIN departamento d ON subquery.lotacao = d.cod_dep
GROUP BY d.nome
ORDER BY media_dependentes DESC;