# FarmTech Solutions - Sistema de Gestão Agrícola

Sistema integrado Python-R para gestão de dados agrícolas com análise estatística e integração climática.

## 📋 Funcionalidades

- **Python:** Sistema de cadastro de campos de soja e milho com menu interativo
- **R:** Análise estatística completa dos dados agrícolas  
- **API Clima:** Integração com dados meteorológicos em tempo real
- **Exportação:** Dados em formato CSV para análise entre linguagens
- **Vetores:** Uso de listas (vetores) para organização dos dados

## 🚀 Como usar

### Passo 1 - Python
1. Execute `fazenda_integrado.py`
2. Use o menu para cadastrar campos de soja e milho
3. Calcule áreas e insumos necessários
4. Use opção [5] para exportar dados para CSV

### Passo 2 - R
1. Execute `analise_rstudio.R` para análises básicas
2. Ou execute `analise_clima.R` para análises com dados climáticos
3. Visualize estatísticas, gráficos e insights

## 📁 Estrutura dos Arquivos

- `fazenda_integrado.py` - Programa principal Python com menu CRUD
- `analise_rstudio.R` - Análise estatística em R (versão RStudio)
- `analise_clima.R` - Análise com integração de API climática
- `dados_fazenda_reais.csv` - Arquivo de dados gerado pelo Python

## 🛠️ Tecnologias Utilizadas

- **Python 3.x** - Linguagem principal para entrada de dados
- **R 4.x** - Análise estatística e visualização
- **CSV** - Formato de intercâmbio de dados
- **Open-Meteo API** - Dados climáticos em tempo real

## 📊 Funcionalidades do Sistema

### Python:
- Cadastro de campos retangulares (soja) e quadrados (milho)
- Cálculo automático de áreas
- Cálculo de insumos (fertilizantes e sementes)
- Sistema CRUD completo (Create, Read, Update, Delete)
- Exportação para CSV

### R:
- Estatísticas descritivas (média, desvio padrão, min/max)
- Comparação entre culturas
- Análise de necessidade de irrigação
- Integração com dados climáticos
- Recomendações específicas por cultura

## 🎓 Contexto Acadêmico

Projeto desenvolvido para o curso de Inteligência Artificial da FIAP - Fase 1

**Objetivos do exercício:**
- Integração entre Python e R
- Uso de vetores (listas) para organização de dados
- Análise estatística de dados agrícolas
- Implementação de sistema CRUD
- Integração com APIs externas

## 👨‍💻 Autor

Desenvolvido como projeto acadêmico para demonstrar integração Python-R em contexto agrícola.

## 📝 Licença

Projeto acadêmico - FIAP 2024

