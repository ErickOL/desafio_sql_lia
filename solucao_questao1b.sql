WITH matriculas_por_dia AS (
   SELECT 
        escolas.name AS escola,
        alunos.enrolled_at AS dia,
        COUNT(alunos.id) AS alunos_matriculados
    FROM students alunos
    INNER JOIN courses cursos ON alunos.course_id = cursos.id
    INNER JOIN schools escolas ON cursos.school_id = escolas.id
    WHERE cursos.name LIKE 'data%'
    GROUP BY escolas.name, alunos.enrolled_at
)
SELECT
    escola,
    dia,
    alunos_matriculados,
    -- Soma acumulada por escola (ordenação cronológica)
    SUM(alunos_matriculados) OVER (
        PARTITION BY escola 
        ORDER BY dia 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS soma_acumulada,
    -- Média móvel dos últimos 7 dias
    ROUND(AVG(alunos_matriculados) OVER (
        PARTITION BY escola 
        ORDER BY dia 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS media_movel_7d,
    -- Média móvel dos últimos 30 dias
    ROUND(AVG(alunos_matriculados) OVER (
        PARTITION BY escola 
        ORDER BY dia 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS media_movel_30d
FROM matriculas_por_dia
ORDER BY dia DESC; -- Mantém ordenação do mais recente para o mais antigo