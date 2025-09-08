# FarmTech Solutions - Análise com Dados Climáticos
# Script R integrado com API Open-Meteo para dados meteorológicos

# Limpar ambiente
rm(list = ls())

# Carregar bibliotecas necessárias
if (!require(jsonlite)) {
  install.packages("jsonlite")
  library(jsonlite)
}

if (!require(httr)) {
  install.packages("httr")
  library(httr)
}

# Função para exibir título
exibir_titulo <- function(titulo) {
  cat("\n", rep("=", 60), "\n")
  cat("  ", titulo, "\n")
  cat(rep("=", 60), "\n\n")
}

# Função para buscar dados climáticos
buscar_dados_clima <- function(latitude = -23.5505, longitude = -46.6333, cidade = "São Paulo") {
  cat("🌤️ Buscando dados climáticos para", cidade, "...\n")
  
  # URL da API Open-Meteo
  url_base <- "https://api.open-meteo.com/v1/forecast"
  
  # Parâmetros da requisição
  params <- list(
    latitude = latitude,
    longitude = longitude,
    current = "temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m",
    hourly = "temperature_2m,precipitation_probability,soil_moisture_0_to_1cm",
    daily = "temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max",
    timezone = "auto",
    forecast_days = 7
  )
  
  # Fazer requisição
  tryCatch({
    response <- GET(url_base, query = params)
    
    if (status_code(response) == 200) {
      dados <- fromJSON(content(response, "text"))
      cat("✅ Dados climáticos obtidos com sucesso!\n\n")
      return(dados)
    } else {
      cat("❌ Erro na requisição:", status_code(response), "\n")
      return(NULL)
    }
  }, error = function(e) {
    cat("❌ Erro ao conectar com a API:", e$message, "\n")
    cat("💡 Verifique sua conexão com a internet.\n")
    return(NULL)
  })
}

# Função para analisar condições climáticas para agricultura
analisar_condicoes_agricolas <- function(dados_clima, cidade) {
  if (is.null(dados_clima)) {
    cat("❌ Não foi possível analisar as condições climáticas.\n")
    return(FALSE)
  }
  
  exibir_titulo(paste("CONDIÇÕES CLIMÁTICAS ATUAIS -", cidade))
  
  # Dados atuais
  atual <- dados_clima$current
  cat("📅 Data/Hora:", atual$time, "\n")
  cat("🌡️ Temperatura:", atual$temperature_2m, "°C\n")
  cat("💧 Umidade:", atual$relative_humidity_2m, "%\n")
  cat("🌧️ Precipitação:", atual$precipitation, "mm\n")
  cat("💨 Vento:", atual$wind_speed_10m, "km/h\n\n")
  
  # Análise das condições para agricultura
  cat("🌱 ANÁLISE PARA AGRICULTURA:\n")
  
  # Temperatura
  temp <- atual$temperature_2m
  if (temp >= 20 && temp <= 30) {
    cat("   ✅ Temperatura ideal para soja e milho (20-30°C)\n")
  } else if (temp < 15) {
    cat("   ⚠️ Temperatura baixa - pode afetar o crescimento\n")
  } else if (temp > 35) {
    cat("   ⚠️ Temperatura alta - risco de estresse térmico\n")
  } else {
    cat("   ⚡ Temperatura aceitável para cultivo\n")
  }
  
  # Umidade
  umidade <- atual$relative_humidity_2m
  if (umidade >= 60 && umidade <= 80) {
    cat("   ✅ Umidade ideal para cultivos (60-80%)\n")
  } else if (umidade < 50) {
    cat("   ⚠️ Umidade baixa - considere irrigação\n")
  } else if (umidade > 85) {
    cat("   ⚠️ Umidade alta - risco de doenças fúngicas\n")
  } else {
    cat("   ⚡ Umidade aceitável\n")
  }
  
  # Vento
  vento <- atual$wind_speed_10m
  if (vento <= 15) {
    cat("   ✅ Vento favorável para aplicação de defensivos\n")
  } else {
    cat("   ⚠️ Vento forte - evite aplicações de defensivos\n")
  }
  
  cat("\n")
  
  # Previsão dos próximos dias
  exibir_titulo("PREVISÃO PARA OS PRÓXIMOS 7 DIAS")
  
  diario <- dados_clima$daily
  for (i in 1:length(diario$time)) {
    data <- diario$time[i]
    temp_max <- diario$temperature_2m_max[i]
    temp_min <- diario$temperature_2m_min[i]
    chuva <- diario$precipitation_sum[i]
    prob_chuva <- diario$precipitation_probability_max[i]
    
    cat("📅", data, "\n")
    cat("   🌡️ Temp: ", temp_min, "°C a ", temp_max, "°C\n")
    cat("   🌧️ Chuva: ", chuva, "mm (", prob_chuva, "% prob.)\n")
    
    # Recomendações
    if (chuva > 10) {
      cat("   💡 Dia chuvoso - evite trabalhos no campo\n")
    } else if (prob_chuva < 30 && temp_max < 35) {
      cat("   ✅ Bom dia para atividades agrícolas\n")
    } else {
      cat("   ⚡ Condições moderadas\n")
    }
    cat("\n")
  }
  
  return(TRUE)
}

# Função para calcular necessidade de irrigação
calcular_irrigacao <- function(dados_clima, area_total) {
  if (is.null(dados_clima)) return(FALSE)
  
  exibir_titulo("ANÁLISE DE NECESSIDADE DE IRRIGAÇÃO")
  
  # Dados dos próximos 7 dias
  diario <- dados_clima$daily
  chuva_total <- sum(diario$precipitation_sum, na.rm = TRUE)
  
  cat("🌧️ Precipitação prevista (7 dias):", round(chuva_total, 2), "mm\n")
  cat("📏 Área total da fazenda:", area_total, "m²\n\n")
  
  # Necessidade de água para cultivos (aproximadamente 5mm por dia)
  necessidade_semanal <- 35  # 5mm x 7 dias
  
  cat("💧 ANÁLISE DE IRRIGAÇÃO:\n")
  cat("   Necessidade semanal: ~", necessidade_semanal, "mm\n")
  cat("   Chuva prevista:", round(chuva_total, 2), "mm\n")
  
  deficit <- necessidade_semanal - chuva_total
  
  if (deficit > 0) {
    cat("   ⚠️ Déficit hídrico:", round(deficit, 2), "mm\n")
    
    # Calcular volume de irrigação necessário
    volume_litros <- (deficit / 1000) * area_total  # mm para metros, depois para litros
    
    cat("   💦 Volume de irrigação recomendado:", round(volume_litros, 0), "litros\n")
    cat("   📊 Isso equivale a", round(volume_litros / area_total * 1000, 2), "mm de lâmina d'água\n")
    
    if (deficit > 20) {
      cat("   🚨 ATENÇÃO: Déficit alto - irrigação urgente necessária!\n")
    } else {
      cat("   💡 Considere irrigação complementar\n")
    }
  } else {
    cat("   ✅ Chuva suficiente - irrigação não necessária\n")
  }
  
  cat("\n")
  return(TRUE)
}

# Função principal integrada
analisar_fazenda_com_clima <- function() {
  exibir_titulo("FARMTECH SOLUTIONS - ANÁLISE INTEGRADA COM CLIMA")
  
  # Verificar se há dados da fazenda
  arquivo_csv <- "dados_fazenda_reais.csv"
  
  if (!file.exists(arquivo_csv)) {
    cat("❌ ERRO: Arquivo 'dados_fazenda_reais.csv' não encontrado!\n")
    cat("💡 Execute primeiro o programa Python para gerar os dados.\n\n")
    return(FALSE)
  }
  
  # Ler dados da fazenda
  cat("📂 Lendo dados da fazenda...\n")
  dados_fazenda <- read.csv(arquivo_csv, stringsAsFactors = FALSE, encoding = "UTF-8")
  
  if (nrow(dados_fazenda) == 0) {
    cat("❌ Arquivo CSV está vazio!\n")
    return(FALSE)
  }
  
  # Calcular área total
  area_total <- sum(dados_fazenda$area)
  
  cat("✅ Dados da fazenda carregados:\n")
  cat("   📊 Total de campos:", nrow(dados_fazenda), "\n")
  cat("   📏 Área total:", area_total, "m²\n\n")
  
  # Buscar dados climáticos (usando coordenadas de exemplo - São Paulo)
  # Em um sistema real, o usuário forneceria as coordenadas da fazenda
  dados_clima <- buscar_dados_clima(-23.5505, -46.6333, "São Paulo")
  
  if (!is.null(dados_clima)) {
    # Analisar condições climáticas
    analisar_condicoes_agricolas(dados_clima, "São Paulo")
    
    # Calcular necessidade de irrigação
    calcular_irrigacao(dados_clima, area_total)
    
    # Recomendações específicas por cultura
    exibir_titulo("RECOMENDAÇÕES POR CULTURA")
    
    dados_soja <- dados_fazenda[dados_fazenda$cultura == "Soja", ]
    dados_milho <- dados_fazenda[dados_fazenda$cultura == "Milho", ]
    
    if (nrow(dados_soja) > 0) {
      cat("🌱 SOJA (", nrow(dados_soja), "campos,", sum(dados_soja$area), "m²):\n")
      
      temp_atual <- dados_clima$current$temperature_2m
      if (temp_atual >= 20 && temp_atual <= 30) {
        cat("   ✅ Temperatura ideal para desenvolvimento\n")
      } else {
        cat("   ⚠️ Monitorar temperatura - pode afetar produtividade\n")
      }
      
      umidade <- dados_clima$current$relative_humidity_2m
      if (umidade > 80) {
        cat("   ⚠️ Alta umidade - risco de ferrugem asiática\n")
        cat("   💡 Considere aplicação preventiva de fungicidas\n")
      }
      cat("\n")
    }
    
    if (nrow(dados_milho) > 0) {
      cat("🌽 MILHO (", nrow(dados_milho), "campos,", sum(dados_milho$area), "m²):\n")
      
      temp_atual <- dados_clima$current$temperature_2m
      if (temp_atual >= 15 && temp_atual <= 35) {
        cat("   ✅ Temperatura adequada para milho\n")
      } else {
        cat("   ⚠️ Temperatura fora da faixa ideal (15-35°C)\n")
      }
      
      # Verificar chuva dos próximos dias para milho
      chuva_3_dias <- sum(dados_clima$daily$precipitation_sum[1:3], na.rm = TRUE)
      if (chuva_3_dias < 5) {
        cat("   💧 Pouca chuva prevista - considere irrigação\n")
      }
      cat("\n")
    }
    
    exibir_titulo("RESUMO EXECUTIVO")
    cat("📊 Análise realizada em:", format(Sys.time(), "%d/%m/%Y %H:%M:%S"), "\n")
    cat("🌍 Localização: São Paulo, SP (exemplo)\n")
    cat("🏠 Total de campos analisados:", nrow(dados_fazenda), "\n")
    cat("📏 Área total:", area_total, "m²\n")
    cat("🌡️ Temperatura atual:", dados_clima$current$temperature_2m, "°C\n")
    cat("💧 Umidade atual:", dados_clima$current$relative_humidity_2m, "%\n")
    
    # Status geral
    temp <- dados_clima$current$temperature_2m
    umidade <- dados_clima$current$relative_humidity_2m
    
    if (temp >= 20 && temp <= 30 && umidade >= 60 && umidade <= 80) {
      cat("✅ STATUS GERAL: Condições ideais para agricultura\n")
    } else if (temp < 15 || temp > 35) {
      cat("⚠️ STATUS GERAL: Atenção à temperatura\n")
    } else {
      cat("⚡ STATUS GERAL: Condições moderadas\n")
    }
    
  } else {
    cat("❌ Não foi possível obter dados climáticos.\n")
    cat("💡 Análise realizada apenas com dados da fazenda.\n")
  }
  
  exibir_titulo("FIM DA ANÁLISE INTEGRADA")
  return(TRUE)
}

# EXECUÇÃO PRINCIPAL
main <- function() {
  cat("🚀 Iniciando análise integrada FarmTech Solutions...\n")
  cat("🌐 Conectando com API Open-Meteo para dados climáticos...\n\n")
  
  sucesso <- analisar_fazenda_com_clima()
  
  if (sucesso) {
    cat("✅ Análise integrada concluída com sucesso!\n")
    cat("📊 Dados da fazenda + condições climáticas analisados.\n")
    cat("🌐 API Open-Meteo: https://open-meteo.com/\n")
  } else {
    cat("❌ Não foi possível completar a análise integrada.\n")
  }
  
  cat("\n💡 NOTA: Em um sistema de produção, as coordenadas\n")
  cat("   geográficas da fazenda seriam fornecidas pelo usuário.\n")
}

# Executar análise integrada
main()

