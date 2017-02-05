# Exprorando os dados do Enem: Nota de pesquisa 1


## A questão racial

Uma primeira pergunta que podemos elaborar é: A auto-declaração de raça/cor é um bom preditor das notas do Enem?

Podemos responder essa questão de maneira simples por dois mecanismos, que nos darão uma resposta muito parecida já que tem como sustentação o mesmo pincípio.^[Pularesmo dois passos importantes, (i) organização dos dados e (ii)criação uma boa estatística descritiva dos dados.] 

(a) O teste ANOVA^[O Lucas tem trabalhado com esse procedimento ele pode te ajudar na utilização.], comparando as médias dos grupos. Será que as médias são diferentes entre os grupos? Será que essa diferença é significante?

(b) Uma regressão linear simples deve produzir um resultado semelhante, com a vantagem de nos fornecer explicitamente o impacto de cada um dos grupos.

Essa é uma abordagem um pouco limitada, pois não leva em consideração nenhum outro possivel efeito (*fator de impacto*) que poderia agravar ou amenizar a situação e diferenças raciais. Os dados em `enem14` devem ser suficientes para nos fornecer respostas precisas. Utilizaremos a função `aov()`.

### ANOVA


```r
teste1 <- aov(NOTA_CN ~ TP_COR_RACA, data=enem14) 
summary(teste1)
```

```
##                Df    Sum Sq Mean Sq F value Pr(>F)    
## TP_COR_RACA     5   4907704  981541   184.3 <2e-16 ***
## Residuals   30782 163926299    5325                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 12964 observations deleted due to missingness
```


Obter um valor de *F* alto indica que as diferenças são consideraveis e um valor de *p* muito pequeno indica que temos informações suficientes para afirmar a diferença entre as médias, ou seja, para o teste ANOVA obtivemos F(5|30782)=184,3 e *p*< 0,001.


### Regressão linear simples

A diferença para o método de regressão linear simples nesse exemplo é apenas a forma como é apresentada ao final. Mas se obeservar os valores ao final do sumario da regressão verá que são os mesmos valores que o modelo ANOVA. Nesse caso o modelo de regressão te permite criar uma *expressão preditora* da nota dos alunos dependendo da **raça/cor**. Utilizaremos a função `lm()`.


```r
modelo1 <- lm(NOTA_CN ~ TP_COR_RACA, data=enem14) 
summary(modelo1)
```

```
## 
## Call:
## lm(formula = NOTA_CN ~ TP_COR_RACA, data = enem14)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -497.52  -53.55   -6.84   46.98  366.95 
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)          494.548      3.345 147.855  < 2e-16 ***
## TP_COR_RACABranca      2.975      3.411   0.872    0.383    
## TP_COR_RACAPreta     -22.499      3.548  -6.341 2.32e-10 ***
## TP_COR_RACAParda     -23.011      3.402  -6.763 1.37e-11 ***
## TP_COR_RACAAmarela    -6.099      4.395  -1.388    0.165    
## TP_COR_RACAIndígena  -29.412      6.478  -4.540 5.65e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 72.98 on 30782 degrees of freedom
##   (12964 observations deleted due to missingness)
## Multiple R-squared:  0.02907,	Adjusted R-squared:  0.02891 
## F-statistic: 184.3 on 5 and 30782 DF,  p-value: < 2.2e-16
```
Nesse caso ele transforma as variáveis de `fatores` para variáveis `dummy`.^[Para mais informações veja o artigo https://periodicos.ufsm.br/cienciaenatura/article/viewFile/9764/5853 .]
Nesse caso temos a equação linear que nos permitirá prever a nota dos estudantes de acordo com a raça/cor. Podemos ver pelos coeficientes estimádos que 
$$ Nota_{NC}= \alpha_{intercept]}+\beta_{Raça|Cor}X $$
$$ NotaNC = 494,55 + Branca(2,98) + Preta(-22,50)+Parda(-23,00)+Amarela(-6,10)+Indígena(-29,41)$$
Isso significa que todas as demais raças estão em desvantagem em relação à *Branca*, contudo é importante notar que essas **desvantagens** não são as mesmas. Por exemplo o grupo de *Indígenas* deve ter média estimada de: 
$$ NotaNC=494,55+(0)(2,98) + (0)(-22,50)+(0)(-23,00)+(0)(-6,10)+(1)(-29,41)$$
$$ NotaNC=494,55+(0)(2,98)-29,41$$
$$NotaNC=465,14_{Indígena}$$
Desse modo podemos perceber que o grupo com maior desvantagem é o *Indígena*, seguido pelos *Pardos* e *Pretos*. Isso nos revela que a cor é um bom preditor para a nota em Ciências da Natureza e que os *Brancos* têm desempenho médio maior quando comparamos com outros grupos. No modelo 1 de regressão linear simples obtivemos F(5|30782)=184,3 e *p*< 0,001.

### Considerações finais
Como foi indicado anteriormente, esse é um modelo simples e limitado, já que não considera outros fatores que podem influênciar o desempenho como, por exemplo, *Sexo*, *Nível Socioeconômico (NSE)*, *Região do país* etc. Mas conseguimos localizar as diferenças entre os grupos. Além disso, conseguímos identificar que o grupo *Indígena* tem o desempenho inferior quando compardo com outros grupos. O que pode transformá-lo em um grupo de interesse na pesquisa.
Esse mesmo procedimento pode ser adotado para diferentes categorias como, por exemplo, identíficar a diferença entre alunos surdos e ouvintes, estudantes da rede pública e privada, etc.

