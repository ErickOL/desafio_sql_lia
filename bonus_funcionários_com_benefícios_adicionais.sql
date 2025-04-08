-- Número de benefícios e valor total por funcionário (incluindo departamento)
SELECT 
    d.nome AS departamento,
    e.nome AS funcionario,
    COUNT(ev.cod_venc) AS qtd_beneficios,
    ROUND(SUM(v.valor), 2) AS total_beneficios
FROM empregado e
INNER JOIN emp_venc ev ON e.matr = ev.matr
INNER JOIN vencimento v ON ev.cod_venc = v.cod_venc
INNER JOIN departamento d ON e.lotacao = d.cod_dep
GROUP BY d.nome, e.nome
HAVING COUNT(ev.cod_venc) > 1  -- Filtra quem tem mais de um benefício
ORDER BY total_beneficios DESC;