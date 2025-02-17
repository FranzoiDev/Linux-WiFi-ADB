#!/bin/bash

# Cores e configurações visuais
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)
LARGURA=50

# Cabeçalho
cabecalho() {
    clear
    echo "${BLUE}${BOLD}╔══════════════════════════════════════════╗"
    echo "║${WHITE}  CONEXÃO DE DEPURAÇÃO ANDROID VIA WiFi   ${BLUE}║"
    echo "╚══════════════════════════════════════════╝${RESET}"
    echo
}

# Mensagens de erro
erro() {
    echo "${RED}${BOLD}⨯ ERRO: $1${RESET}"
    echo
    exit 1
}

# Desenha linha divisória
linha_divisoria() {
    echo "${CYAN}──────────────────────────────────────────────────${RESET}"
}

# Verifica platform-tools
PLATFORM_TOOLS="$HOME/Android/Sdk/platform-tools"
cabecalho
if [ ! -d "$PLATFORM_TOOLS" ]; then
    erro "Diretório platform-tools não encontrado em:
    $PLATFORM_TOOLS
Verifique a instalação do Android SDK."
fi

# Coleta informações
cabecalho
echo "${BOLD}${GREEN}►► Informe os dados do dispositivo:${RESET}"
linha_divisoria
echo -n "${BOLD}${YELLOW}► Endereço IP: ${RESET}"
read -r IP
echo -n "${BOLD}${YELLOW}► Porta: ${RESET}"
read -r PORTA

# Validação de entrada
if [ -z "$IP" ] || [ -z "$PORTA" ]; then
    cabecalho
    erro "IP e porta são obrigatórios!"
fi

# Processo de pareamento
cabecalho
echo "${BOLD}${GREEN}►► Iniciando pareamento em ${WHITE}$IP:$PORTA${RESET}"
linha_divisoria
echo "${YELLOW}› Aguardando código de pareamento..."
echo "› O código será exibido no dispositivo Android"
echo "› Prepare-se para digitá-lo quando solicitado${RESET}"
linha_divisoria

cd "$PLATFORM_TOOLS" || erro "Não foi possível acessar o diretório!"

# Executa o comando de pareamento
if ! ./adb pair "$IP:$PORTA"; then
    erro "Falha no pareamento! Verifique os dados e conexão."
fi

# Finalização
cabecalho
echo "${GREEN}${BOLD}✔ Pareamento realizado com sucesso!${RESET}"
linha_divisoria
echo "${BOLD}Pressione ENTER para finalizar...${RESET}"
read -r

cabecalho
echo "${GREEN}${BOLD}Script concluído!${RESET}"
echo