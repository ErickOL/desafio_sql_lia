SELECT 
    d.nome AS departamento,
    COUNT(DISTINCT e.matr) AS quantidade_empregados,
    ROUND(COALESCE(AVG(salario_total), 0), 2) AS media_salarial,
    COALESCE(MAX(salario_total), 0) AS maior_salario,
    COALESCE(MIN(salario_total), 0) AS menor_salario
FROM departamento d
LEFT JOIN (
    -- Subconsulta para calcular o salário total de cada empregado
    SELECT 
        e.matr,
        e.lotacao AS cod_dep,
        SUM(v.valor) AS salario_total
    FROM empregado e
    LEFT JOIN emp_venc ev ON e.matr = ev.matr
    LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
    GROUP BY e.matr, e.lotacao
) salarios ON d.cod_dep = salarios.cod_dep
LEFT JOIN empregado e ON d.cod_dep = e.lotacao
GROUP BY d.cod_dep, d.nome
ORDER BY media_salarial DESC;