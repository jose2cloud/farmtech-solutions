# FarmTech Solutions - Análise Estatística REAL
# Script R que usa APENAS dados exportados do Python
# VERSÃO ADAPTADA PARA RSTUDIO

setwd("C:/Users/josel/OneDrive/Materiais 2022/AI FIAP/Fase 1/Fazenda/Integrados2")

# Limpar ambiente
rm(list = ls())

# CONFIGURAÇÃO PARA RSTUDIO
# Verificar e definir diretório de trabalho
cat("🔍 VERIFICANDO DIRETÓRIO DE TRABALHO:\n")
cat("   Diretório atual:", getwd(), "\n")

# Se você estiver usando RStudio, descomente a linha abaixo e coloque o caminho correto:
# setwd("C:/caminho/para/sua/pasta")  # Windows
# setwd("/home/usuario/pasta")        # Linux
# setwd("/Users/usuario/pasta")       # Mac

cat("   Arquivos CSV na pasta:\n")
arquivos_csv <- list.files(pattern = "*.csv")
if (length(arquivos_csv) > 0) {
  for (i in 1:length(arquivos_csv)) {
    cat("   ", i, ".", arquivos_csv[i], "\n")
  }
} else {
  cat("   ❌ Nenhum arquivo CSV encontrado!\n")
  cat("   💡 Certifique-se de que o arquivo 'dados_fazenda_reais.csv' está na pasta correta.\n")
}
cat("\n")

# Função para exibir título
exibir_titulo <- function(titulo) {
  cat("\n", rep("=", 50), "\n")
  cat("  ", titulo, "\n")
  cat(rep("=", 50), "\n\n")
}

# Função principal de análise
analisar_dados_reais <- function() {
  # Verificar se o arquivo existe
  arquivo_csv <- "dados_fazenda_reais.csv"
  
  if (!file.exists(arquivo_csv)) {
    cat("❌ ERRO: Arquivo 'dados_fazenda_reais.csv' não encontrado!\n")
    cat("📂 Diretório atual:", getwd(), "\n")
    cat("💡 SOLUÇÃO:\n")
    cat("   1. Execute o programa Python (fazenda_integrado.py)\n")
    cat("   2. Cadastre alguns campos de soja e milho\n")
    cat("   3. Use a opção [5] para exportar dados\n")
    cat("   4. Certifique-se de que o arquivo CSV está na mesma pasta que este script R\n")
    cat("   5. No RStudio, use Session > Set Working Directory > To Source File Location\n\n")
    return(FALSE)
  }
  
  # Ler dados do CSV
  cat("📂 Lendo dados reais do arquivo CSV...\n")
  dados <- read.csv(arquivo_csv, stringsAsFactors = FALSE, encoding = "UTF-8")
  
  # Verificar se há dados
  if (nrow(dados) == 0) {
    cat("❌ ERRO: Arquivo CSV está vazio!\n")
    cat("💡 Cadastre alguns campos no programa Python primeiro.\n\n")
    return(FALSE)
  }
  
  # Separar dados por cultura
  dados_soja <- dados[dados$cultura == "Soja", ]
  dados_milho <- dados[dados$cultura == "Milho", ]
  
  # Gerar relatório
  exibir_titulo("FARMTECH SOLUTIONS - ANÁLISE DOS SEUS DADOS")
  
  cat("📅 Data do Relatório:", format(Sys.Date(), "%d/%m/%Y"), "\n")
  cat("⏰ Hora:", format(Sys.time(), "%H:%M:%S"), "\n")
  cat("📂 Fonte dos Dados: dados_fazenda_reais.csv\n")
  cat("📊 Total de Registros:", nrow(dados), "\n\n")
  
  # Analisar Soja
  if (nrow(dados_soja) > 0) {
    exibir_titulo("ESTATÍSTICAS - SOJA (SEUS DADOS)")
    
    cat("📊 ÁREA DOS CAMPOS:\n")
    cat("   Número de Campos:", nrow(dados_soja), "\n")
    cat("   Média:", round(mean(dados_soja$area), 2), "m²\n")
    
    if (nrow(dados_soja) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_soja$area), 2), "m²\n")
    } else {
      cat("   Desvio Padrão: N/A (apenas 1 campo)\n")
    }
    
    cat("   Mínimo:", min(dados_soja$area), "m²\n")
    cat("   Máximo:", max(dados_soja$area), "m²\n")
    cat("   Total:", sum(dados_soja$area), "m²\n\n")
    
    cat("🧪 FERTILIZANTE NECESSÁRIO:\n")
    cat("   Média:", round(mean(dados_soja$fertilizante_litros), 2), "litros\n")
    if (nrow(dados_soja) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_soja$fertilizante_litros), 2), "litros\n")
    }
    cat("   Total:", sum(dados_soja$fertilizante_litros), "litros\n\n")
    
    cat("🌱 SEMENTES NECESSÁRIAS:\n")
    cat("   Média:", round(mean(dados_soja$sementes_kg), 2), "kg\n")
    if (nrow(dados_soja) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_soja$sementes_kg), 2), "kg\n")
    }
    cat("   Total:", sum(dados_soja$sementes_kg), "kg\n\n")
    
    # Detalhes dos campos
    cat("📋 SEUS CAMPOS DE SOJA:\n")
    for (i in 1:nrow(dados_soja)) {
      campo <- dados_soja[i, ]
      cat("   ", i, ".", campo$nome, "- Área:", campo$area, "m²\n")
    }
    cat("\n")
  } else {
    cat("🌱 Você não cadastrou campos de soja ainda.\n\n")
  }
  
  # Analisar Milho
  if (nrow(dados_milho) > 0) {
    exibir_titulo("ESTATÍSTICAS - MILHO (SEUS DADOS)")
    
    cat("📊 ÁREA DOS CAMPOS:\n")
    cat("   Número de Campos:", nrow(dados_milho), "\n")
    cat("   Média:", round(mean(dados_milho$area), 2), "m²\n")
    
    if (nrow(dados_milho) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_milho$area), 2), "m²\n")
    } else {
      cat("   Desvio Padrão: N/A (apenas 1 campo)\n")
    }
    
    cat("   Mínimo:", min(dados_milho$area), "m²\n")
    cat("   Máximo:", max(dados_milho$area), "m²\n")
    cat("   Total:", sum(dados_milho$area), "m²\n\n")
    
    cat("🧪 FERTILIZANTE NECESSÁRIO:\n")
    cat("   Média:", round(mean(dados_milho$fertilizante_litros), 2), "litros\n")
    if (nrow(dados_milho) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_milho$fertilizante_litros), 2), "litros\n")
    }
    cat("   Total:", sum(dados_milho$fertilizante_litros), "litros\n\n")
    
    cat("🌽 SEMENTES NECESSÁRIAS:\n")
    cat("   Média:", round(mean(dados_milho$sementes_kg), 2), "kg\n")
    if (nrow(dados_milho) > 1) {
      cat("   Desvio Padrão:", round(sd(dados_milho$sementes_kg), 2), "kg\n")
    }
    cat("   Total:", sum(dados_milho$sementes_kg), "kg\n\n")
    
    # Detalhes dos campos
    cat("📋 SEUS CAMPOS DE MILHO:\n")
    for (i in 1:nrow(dados_milho)) {
      campo <- dados_milho[i, ]
      cat("   ", i, ".", campo$nome, "- Área:", campo$area, "m²\n")
    }
    cat("\n")
  } else {
    cat("🌽 Você não cadastrou campos de milho ainda.\n\n")
  }
  
  # Comparação entre culturas
  if (nrow(dados_soja) > 0 && nrow(dados_milho) > 0) {
    exibir_titulo("COMPARAÇÃO ENTRE SUAS CULTURAS")
    
    area_media_soja <- mean(dados_soja$area)
    area_media_milho <- mean(dados_milho$area)
    
    cat("📐 ÁREA MÉDIA POR CAMPO:\n")
    cat("   Soja:", round(area_media_soja, 2), "m²\n")
    cat("   Milho:", round(area_media_milho, 2), "m²\n")
    
    if (area_media_soja > area_media_milho) {
      cat("   → Seus campos de soja são maiores em média\n\n")
    } else if (area_media_milho > area_media_soja) {
      cat("   → Seus campos de milho são maiores em média\n\n")
    } else {
      cat("   → Seus campos têm área média similar\n\n")
    }
    
    total_fertilizante_soja <- sum(dados_soja$fertilizante_litros)
    total_fertilizante_milho <- sum(dados_milho$fertilizante_litros)
    
    cat("🧪 TOTAL DE FERTILIZANTE:\n")
    cat("   Soja:", total_fertilizante_soja, "litros\n")
    cat("   Milho:", total_fertilizante_milho, "litros\n")
    cat("   Total Geral:", total_fertilizante_soja + total_fertilizante_milho, "litros\n\n")
    
    total_sementes_soja <- sum(dados_soja$sementes_kg)
    total_sementes_milho <- sum(dados_milho$sementes_kg)
    
    cat("🌱 TOTAL DE SEMENTES:\n")
    cat("   Soja:", total_sementes_soja, "kg\n")
    cat("   Milho:", total_sementes_milho, "kg\n")
    cat("   Total Geral:", total_sementes_soja + total_sementes_milho, "kg\n\n")
  }
  
  # Resumo geral
  exibir_titulo("RESUMO GERAL DA SUA FAZENDA")
  
  total_campos <- nrow(dados)
  total_area <- sum(dados$area)
  
  cat("🏠 Total de Campos:", total_campos, "\n")
  cat("📏 Área Total:", total_area, "m²\n")
  cat("🌱 Campos de Soja:", nrow(dados_soja), "\n")
  cat("🌽 Campos de Milho:", nrow(dados_milho), "\n\n")
  
  cat("💡 INSIGHTS SOBRE SUA FAZENDA:\n")
  if (nrow(dados_soja) > nrow(dados_milho)) {
    cat("   • Você tem mais campos de soja\n")
  } else if (nrow(dados_milho) > nrow(dados_soja)) {
    cat("   • Você tem mais campos de milho\n")
  } else if (nrow(dados_soja) == nrow(dados_milho) && nrow(dados_soja) > 0) {
    cat("   • Você tem igual número de campos de soja e milho\n")
  }
  
  if (total_campos > 0) {
    area_media_geral <- total_area / total_campos
    cat("   • Área média por campo:", round(area_media_geral, 2), "m²\n")
    
    if (area_media_geral > 5000) {
      cat("   • Seus campos são de grande porte (>5000m²)\n")
    } else {
      cat("   • Seus campos são de médio porte (<5000m²)\n")
    }
  }
  
  cat("\n")
  exibir_titulo("FIM DO RELATÓRIO DOS SEUS DADOS")
  
  return(TRUE)
}

# EXECUÇÃO PRINCIPAL
main <- function() {
  cat("🚀 Iniciando análise dos SEUS dados da FarmTech Solutions...\n\n")
  
  sucesso <- analisar_dados_reais()
  
  if (sucesso) {
    cat("✅ Análise concluída com sucesso!\n")
    cat("📊 Todos os dados analisados são os que VOCÊ cadastrou no Python.\n")
  } else {
    cat("❌ Não foi possível completar a análise.\n")
    cat("💡 Certifique-se de ter exportado dados do programa Python.\n")
  }
}

# Executar análise
main()

