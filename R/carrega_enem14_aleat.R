#######################################
#### Carrega dados do ENEM 2014
#### Carrega 1% dos dados em escola aleatória de linhas
#######################################

# Identifica pasta onde estão os dados
setwd("~/dados/enem/2014/DADOS/") # lembre de substituir pasta onde está o arquivo do ENEM completo

# Carrega bibliotecas
library(data.table)

# Cria arquivo reduzido a partir de seleção aleatória
system("perl -ne 'print if (rand() < .01)' MICRODADOS_ENEM_2014.csv > enem14.csv")

enem14<-read.csv(file="enem14.csv")

# Lê a primeira linha - apenas para pegar o nome das variávies (colunas)
ehead<-read.csv(file="MICRODADOS_ENEM_2014.csv", nrows=1)

# Ajusta nome das variáveis
colnames(enem14)<-colnames(ehead)

# Transforma em data.table
enem14<-as.data.table(enem14)

## Verifica dados
# Mostra a strutura do banco de dados
str(enem14)

# Cria sumário da variável <<idade>>
summary(enem14$IDADE)
boxplot(enem14$IDADE) 

# Deleta df desnecessário
rm(ehead)
