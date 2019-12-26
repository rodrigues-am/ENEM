#######################################
#### Carrega dados do ENEM 2012
#### Carrega 1% dos dados em escola aleatória de linhas
#######################################

# Identifica pasta onde estão os dados
setwd("~/dados/enem/2018/DADOS/") # lembre de substituir pasta onde está o arquivo do ENEM completo

# Carrega bibliotecas
library(data.table)

# Cria arquivo reduzido a partir de seleção aleatória
system("perl -ne 'print if (rand() < .1)' MICRODADOS_ENEM_2018.csv > enem18.csv")

enem18<-fread(file="enem18.csv", sep=";", dec=",", header = FALSE)

# Lê a primeira linha - apenas para pegar o nome das variávies (colunas)
ehead<-fread(file="MICRODADOS_ENEM_2018.csv", sep=";", dec=",", nrows=1)

# Ajusta nome das variáveis
colnames(enem18)<-colnames(ehead)

## Verifica dados
# Mostra a strutura do banco de dados
str(enem18)

# Cria sumário da variável <<idade>>
summary(as.factor(enem18$TP_SEXO))


# Deleta df desnecessário
rm(ehead)
