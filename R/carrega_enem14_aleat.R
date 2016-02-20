#######################################
#### Carrega dados do ENEM 2014
#### Carrega 1% dos dados em escola aleatória de linhas
#######################################

# Identifica pasta onde estão os dados
setwd("~/dados/enem/2014/DADOS/") # lembre de substituir pasta onde está o arquivo do ENEM completo

# Carrega bibliotecas
library(data.table)

# Cria arquivo reduzido a partir de seleção aleatória
system("perl -ne 'print if (rand() < .01)' MICRODADOS_ENEM_2014.csv > ENEM_2014.csv")

# Lê a primeira linha - apenas para pegar o nome das variávies (colunas)
ehead<-read.csv(file="MICRODADOS_ENEM_2014.csv",nrows=1)

# Ajusta nome das variáveis
colnames(ENEM_2014)<-colnames(ehead)

# Transforma em data.table
ENEM_2014<-as.data.table(ENEM_2014)

## Verifica dados
# Mostra a strutura do banco de dados
str(ENEM_2014)

# Cria sumário da variável <<idade>>
summary(ENEM_2014$IDADE)
boxplot(ENEM_2014$IDADE) 