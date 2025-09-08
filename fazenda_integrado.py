# FarmTech Solutions - Sistema de Agricultura Digital
# Versão Integrada com R - Exporta dados reais para análise

import csv
import os

# Nossas "gavetas" para guardar os dados
dados_soja = []  # Lista para guardar todos os campos de soja
dados_milho = []  # Lista para guardar todos os campos de milho

def mostrar_menu():
    """Mostra o menu principal do sistema"""
    print("\n" + "="*50)
    print("    FARMTECH SOLUTIONS - AGRICULTURA DIGITAL")
    print("="*50)
    print("[1] Adicionar novos dados de plantio")
    print("[2] Ver dados salvos")
    print("[3] Atualizar dados existentes")
    print("[4] Apagar dados")
    print("[5] Exportar dados para análise R")
    print("[6] Sair do programa")
    print("="*50)

def calcular_area_soja(largura, comprimento):
    """Calcula a área de um campo de soja (retângulo)"""
    area = largura * comprimento
    return area

def calcular_area_milho(lado):
    """Calcula a área de um campo de milho (quadrado)"""
    area = lado * lado
    return area

def calcular_insumos_soja(area):
    """Calcula quantos insumos são necessários para a soja"""
    fertilizante = area * 2
    sementes = area * 0.5
    return fertilizante, sementes

def calcular_insumos_milho(area):
    """Calcula quantos insumos são necessários para o milho"""
    fertilizante = area * 1.5
    sementes = area * 0.3
    return fertilizante, sementes

def adicionar_campo_soja():
    """Adiciona um novo campo de soja"""
    print("\n🌱 CADASTRO DE CAMPO DE SOJA")
    print("-" * 30)
    
    nome = input("Nome do campo (ex: Campo Norte): ")
    
    try:
        largura = float(input("Largura do campo (em metros): "))
        comprimento = float(input("Comprimento do campo (em metros): "))
        
        area = calcular_area_soja(largura, comprimento)
        fertilizante, sementes = calcular_insumos_soja(area)
        
        campo = {
            'nome': nome,
            'largura': largura,
            'comprimento': comprimento,
            'area': area,
            'fertilizante_litros': fertilizante,
            'sementes_kg': sementes,
            'cultura': 'Soja'
        }
        
        dados_soja.append(campo)
        
        print(f"\n✅ Campo cadastrado com sucesso!")
        print(f"📐 Área calculada: {area:.2f} m²")
        print(f"🧪 Fertilizante necessário: {fertilizante:.2f} litros")
        print(f"🌱 Sementes necessárias: {sementes:.2f} kg")
        
    except ValueError:
        print("❌ Erro: Digite apenas números para as medidas!")

def adicionar_campo_milho():
    """Adiciona um novo campo de milho"""
    print("\n🌽 CADASTRO DE CAMPO DE MILHO")
    print("-" * 30)
    
    nome = input("Nome do campo (ex: Campo Sul): ")
    
    try:
        lado = float(input("Lado do campo quadrado (em metros): "))
        
        area = calcular_area_milho(lado)
        fertilizante, sementes = calcular_insumos_milho(area)
        
        campo = {
            'nome': nome,
            'lado': lado,
            'area': area,
            'fertilizante_litros': fertilizante,
            'sementes_kg': sementes,
            'cultura': 'Milho'
        }
        
        dados_milho.append(campo)
        
        print(f"\n✅ Campo cadastrado com sucesso!")
        print(f"📐 Área calculada: {area:.2f} m²")
        print(f"🧪 Fertilizante necessário: {fertilizante:.2f} litros")
        print(f"🌽 Sementes necessárias: {sementes:.2f} kg")
        
    except ValueError:
        print("❌ Erro: Digite apenas números para as medidas!")

def adicionar_dados():
    """Função principal para adicionar novos dados"""
    print("\n📱 ADICIONAR NOVOS DADOS DE PLANTIO")
    print("=" * 40)
    print("Qual cultura você quer cadastrar?")
    print("[1] Soja (campo retangular)")
    print("[2] Milho (campo quadrado)")
    print("[3] Voltar ao menu principal")
    
    opcao = input("\nDigite sua escolha (1-3): ")
    
    if opcao == "1":
        adicionar_campo_soja()
    elif opcao == "2":
        adicionar_campo_milho()
    elif opcao == "3":
        print("Voltando ao menu principal...")
    else:
        print("❌ Opção inválida! Digite 1, 2 ou 3.")

def ver_dados():
    """Mostra todos os dados salvos"""
    print("\n📊 DADOS SALVOS")
    print("=" * 30)
    
    if dados_soja:
        print("\n🌱 CAMPOS DE SOJA:")
        for i, campo in enumerate(dados_soja, 1):
            print(f"\n  Campo {i}: {campo['nome']}")
            print(f"  📐 Dimensões: {campo['largura']}m × {campo['comprimento']}m")
            print(f"  📏 Área: {campo['area']:.2f} m²")
            print(f"  🧪 Fertilizante: {campo['fertilizante_litros']:.2f} litros")
            print(f"  🌱 Sementes: {campo['sementes_kg']:.2f} kg")
    else:
        print("\n🌱 Nenhum campo de soja cadastrado ainda.")
    
    if dados_milho:
        print("\n🌽 CAMPOS DE MILHO:")
        for i, campo in enumerate(dados_milho, 1):
            print(f"\n  Campo {i}: {campo['nome']}")
            print(f"  📐 Lado: {campo['lado']}m")
            print(f"  📏 Área: {campo['area']:.2f} m²")
            print(f"  🧪 Fertilizante: {campo['fertilizante_litros']:.2f} litros")
            print(f"  🌽 Sementes: {campo['sementes_kg']:.2f} kg")
    else:
        print("\n🌽 Nenhum campo de milho cadastrado ainda.")

def exportar_para_r():
    """Exporta os dados para análise em R"""
    if not dados_soja and not dados_milho:
        print("❌ Não há dados para exportar! Cadastre alguns campos primeiro.")
        return
    
    print("\n💾 EXPORTANDO DADOS PARA R")
    print("=" * 30)
    
    # Preparar dados para CSV
    todos_dados = []
    
    # Adicionar dados da soja
    for campo in dados_soja:
        todos_dados.append({
            'nome': campo['nome'],
            'cultura': 'Soja',
            'largura': campo['largura'],
            'comprimento': campo['comprimento'],
            'lado': '',  # Vazio para soja
            'area': campo['area'],
            'fertilizante_litros': campo['fertilizante_litros'],
            'sementes_kg': campo['sementes_kg']
        })
    
    # Adicionar dados do milho
    for campo in dados_milho:
        todos_dados.append({
            'nome': campo['nome'],
            'cultura': 'Milho',
            'largura': '',  # Vazio para milho
            'comprimento': '',  # Vazio para milho
            'lado': campo['lado'],
            'area': campo['area'],
            'fertilizante_litros': campo['fertilizante_litros'],
            'sementes_kg': campo['sementes_kg']
        })
    
    # Salvar em CSV
    nome_arquivo = 'dados_fazenda_reais.csv'
    try:
        with open(nome_arquivo, 'w', newline='', encoding='utf-8') as arquivo:
            campos = ['nome', 'cultura', 'largura', 'comprimento', 'lado', 'area', 'fertilizante_litros', 'sementes_kg']
            writer = csv.DictWriter(arquivo, fieldnames=campos)
            
            writer.writeheader()
            writer.writerows(todos_dados)
        
        print(f"✅ Dados exportados com sucesso para '{nome_arquivo}'!")
        print(f"📊 Total de campos exportados: {len(todos_dados)}")
        print(f"🌱 Campos de soja: {len(dados_soja)}")
        print(f"🌽 Campos de milho: {len(dados_milho)}")
        print("\n💡 Agora você pode executar o script R para ver as análises!")
        
    except Exception as e:
        print(f"❌ Erro ao exportar dados: {e}")

def atualizar_dados():
    """Função principal para atualizar dados existentes"""
    print("\n✏️ ATUALIZAR DADOS EXISTENTES")
    print("=" * 40)
    
    if not dados_soja and not dados_milho:
        print("❌ Não há dados cadastrados para atualizar!")
        return
    
    print("Qual cultura você quer atualizar?")
    print("[1] Soja")
    print("[2] Milho")
    print("[3] Voltar ao menu principal")
    
    opcao = input("\nDigite sua escolha (1-3): ")
    
    if opcao == "1":
        if not dados_soja:
            print("❌ Não há campos de soja cadastrados!")
            return
        
        print("\n🌱 CAMPOS DE SOJA DISPONÍVEIS:")
        for i, campo in enumerate(dados_soja, 1):
            print(f"  [{i}] {campo['nome']} - {campo['area']:.2f} m²")
        
        try:
            escolha = int(input("\nQual campo você quer atualizar? ")) - 1
            if 0 <= escolha < len(dados_soja):
                campo = dados_soja[escolha]
                print(f"\n✏️ ATUALIZANDO CAMPO: {campo['nome']}")
                
                novo_nome = input(f"Novo nome (atual: {campo['nome']}): ").strip()
                if novo_nome:
                    campo['nome'] = novo_nome
                
                nova_largura = input(f"Nova largura (atual: {campo['largura']}m): ").strip()
                if nova_largura:
                    campo['largura'] = float(nova_largura)
                
                novo_comprimento = input(f"Novo comprimento (atual: {campo['comprimento']}m): ").strip()
                if novo_comprimento:
                    campo['comprimento'] = float(novo_comprimento)
                
                campo['area'] = calcular_area_soja(campo['largura'], campo['comprimento'])
                campo['fertilizante_litros'], campo['sementes_kg'] = calcular_insumos_soja(campo['area'])
                
                print(f"\n✅ Campo atualizado com sucesso!")
                print(f"📐 Nova área: {campo['area']:.2f} m²")
            else:
                print("❌ Número inválido!")
        except ValueError:
            print("❌ Digite apenas números!")
    
    elif opcao == "2":
        if not dados_milho:
            print("❌ Não há campos de milho cadastrados!")
            return
        
        print("\n🌽 CAMPOS DE MILHO DISPONÍVEIS:")
        for i, campo in enumerate(dados_milho, 1):
            print(f"  [{i}] {campo['nome']} - {campo['area']:.2f} m²")
        
        try:
            escolha = int(input("\nQual campo você quer atualizar? ")) - 1
            if 0 <= escolha < len(dados_milho):
                campo = dados_milho[escolha]
                print(f"\n✏️ ATUALIZANDO CAMPO: {campo['nome']}")
                
                novo_nome = input(f"Novo nome (atual: {campo['nome']}): ").strip()
                if novo_nome:
                    campo['nome'] = novo_nome
                
                novo_lado = input(f"Novo lado (atual: {campo['lado']}m): ").strip()
                if novo_lado:
                    campo['lado'] = float(novo_lado)
                
                campo['area'] = calcular_area_milho(campo['lado'])
                campo['fertilizante_litros'], campo['sementes_kg'] = calcular_insumos_milho(campo['area'])
                
                print(f"\n✅ Campo atualizado com sucesso!")
                print(f"📐 Nova área: {campo['area']:.2f} m²")
            else:
                print("❌ Número inválido!")
        except ValueError:
            print("❌ Digite apenas números!")
    
    elif opcao == "3":
        print("Voltando ao menu principal...")
    else:
        print("❌ Opção inválida! Digite 1, 2 ou 3.")

def apagar_dados():
    """Função principal para apagar dados"""
    print("\n🗑️ APAGAR DADOS")
    print("=" * 40)
    
    if not dados_soja and not dados_milho:
        print("❌ Não há dados cadastrados para apagar!")
        return
    
    print("Qual cultura você quer apagar?")
    print("[1] Soja")
    print("[2] Milho")
    print("[3] Voltar ao menu principal")
    
    opcao = input("\nDigite sua escolha (1-3): ")
    
    if opcao == "1":
        if not dados_soja:
            print("❌ Não há campos de soja cadastrados!")
            return
        
        print("\n🌱 CAMPOS DE SOJA DISPONÍVEIS:")
        for i, campo in enumerate(dados_soja, 1):
            print(f"  [{i}] {campo['nome']} - {campo['area']:.2f} m²")
        
        try:
            escolha = int(input("\nQual campo você quer apagar? ")) - 1
            if 0 <= escolha < len(dados_soja):
                campo_removido = dados_soja.pop(escolha)
                print(f"✅ Campo '{campo_removido['nome']}' foi apagado com sucesso!")
            else:
                print("❌ Número inválido!")
        except ValueError:
            print("❌ Digite apenas números!")
    
    elif opcao == "2":
        if not dados_milho:
            print("❌ Não há campos de milho cadastrados!")
            return
        
        print("\n🌽 CAMPOS DE MILHO DISPONÍVEIS:")
        for i, campo in enumerate(dados_milho, 1):
            print(f"  [{i}] {campo['nome']} - {campo['area']:.2f} m²")
        
        try:
            escolha = int(input("\nQual campo você quer apagar? ")) - 1
            if 0 <= escolha < len(dados_milho):
                campo_removido = dados_milho.pop(escolha)
                print(f"✅ Campo '{campo_removido['nome']}' foi apagado com sucesso!")
            else:
                print("❌ Número inválido!")
        except ValueError:
            print("❌ Digite apenas números!")
    
    elif opcao == "3":
        print("Voltando ao menu principal...")
    else:
        print("❌ Opção inválida! Digite 1, 2 ou 3.")

def main():
    """Função principal do programa"""
    print("Bem-vindo ao Sistema FarmTech Solutions!")
    print("Vamos ajudar você a gerenciar sua fazenda digital!")
    
    while True:
        mostrar_menu()
        opcao = input("Digite sua escolha (1-6): ")
        
        if opcao == "1":
            adicionar_dados()
        elif opcao == "2":
            ver_dados()
        elif opcao == "3":
            atualizar_dados()
        elif opcao == "4":
            apagar_dados()
        elif opcao == "5":
            exportar_para_r()
        elif opcao == "6":
            print("\n👋 Obrigado por usar o FarmTech Solutions!")
            print("Até a próxima!")
            break
        else:
            print("\n❌ Opção inválida! Por favor, digite um número de 1 a 6.")
        
        input("\nPressione ENTER para continuar...")

if __name__ == "__main__":
    main()

