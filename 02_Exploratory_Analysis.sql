-- Eploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off) ,MAX(percentage_laid_off), MIN(total_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC ;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MAX(`date`), MIN(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`, 1 , 7)  AS `MONTH` , SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1 , 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

WITH Rolling_total AS 
(
SELECT SUBSTRING(`date`, 1 , 7)  AS `MONTH` , SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1 , 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1
)
SELECT `MONTH`,total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS ROLLING_TOTAL
FROM Rolling_total;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (COMPANY, YEARS, TOTALS_LAID_OFF) as 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank as(
SELECT *, DENSE_RANK() OVER(PARTITION BY YEARS ORDER BY TOTALS_LAID_OFF DESC ) AS DR
FROM Company_Year
WHERE YEARS IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE DR <= 5
;












